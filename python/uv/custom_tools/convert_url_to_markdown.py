# /// script
# requires-python = ">=3.10"
# dependencies = [
#   "playwright",  # Modern browser automation library
#   "html2text",   # HTML to Markdown conversion library
#   "typer",       # Type-based CLI creation library
# ]
# ///

import asyncio
import sys
import typer
from typing import Optional
from playwright.async_api import (
    async_playwright,
    TimeoutError as PlaywrightTimeoutError,
)
import html2text
from urllib.parse import urlparse

# Typer creates CLI applications with type annotations
app = typer.Typer()


async def fetch_webpage_content(url: str, timeout: int = 30000) -> str:
    """
    Fetch the HTML content of a webpage using Playwright.

    Playwright is a modern browser automation library that provides a high-level API
    to control browsers (Chromium, Firefox, WebKit). Unlike curl/wget which only perform
    HTTP requests, Playwright:

    1. Executes JavaScript on the page, ensuring dynamically loaded content is captured
    2. Renders the page as a real browser would, including CSS styles
    3. Can interact with the page (click buttons, fill forms) before capturing content
    4. Handles modern web features like service workers and SPAs (Single Page Applications)
    5. Provides browser-like networking with proper headers, cookies, and authentication
    6. Can wait for specific elements or network requests to complete

    This makes Playwright ideal for modern websites where content is loaded dynamically
    via JavaScript, which curl/wget would miss entirely.

    Args:
        url: The URL of the webpage to fetch
        timeout: Maximum navigation time in milliseconds

    Returns:
        The fully rendered HTML content of the webpage

    Raises:
        ValueError: If the URL is invalid
        PlaywrightTimeoutError: If the page load times out
        Exception: For other Playwright or connection errors
    """
    # Validate URL format
    parsed_url = urlparse(url)
    if not parsed_url.scheme or not parsed_url.netloc:
        raise ValueError(
            f"Invalid URL format: {url}. URL must include scheme (http:// or https://) and domain."
        )

    try:
        async with async_playwright() as p:
            # Launch a headless Chromium browser
            browser = await p.chromium.launch()
            try:
                # Create a new browser page/tab
                page = await browser.new_page()
                # Navigate to the specified URL and wait for page to load with timeout
                await page.goto(url, timeout=timeout, wait_until="networkidle")
                # Get the fully rendered HTML content
                content = await page.content()
                return content
            except PlaywrightTimeoutError:
                raise PlaywrightTimeoutError(
                    f"Timeout while loading {url}. The page took too long to respond."
                )
            except Exception as e:
                raise Exception(f"Error while fetching page: {str(e)}")
            finally:
                # Clean up by closing the browser
                await browser.close()
    except Exception as e:
        # Catch any Playwright initialization errors
        raise Exception(f"Failed to initialize browser: {str(e)}")


def convert_html_to_markdown(html_content: str) -> str:
    """
    Convert HTML content to Markdown using html2text.

    html2text is a Python library that converts HTML to Markdown format.
    It preserves the structure of the document while simplifying the markup
    to a more readable plain text format that can be easily edited and
    version-controlled.

    Args:
        html_content: The HTML content to convert

    Returns:
        The Markdown representation of the HTML content

    Raises:
        Exception: If the HTML to Markdown conversion fails
    """
    try:
        # Create a converter instance
        converter = html2text.HTML2Text()
        # Configure the converter to preserve links
        converter.ignore_links = False
        # Configure the converter to preserve images
        converter.ignore_images = False
        # Configure the converter to preserve tables
        converter.ignore_tables = False
        # Convert HTML to Markdown
        return converter.handle(html_content)
    except Exception as e:
        raise Exception(f"Failed to convert HTML to Markdown: {str(e)}")


@app.command()
def convert(
    url: str,
    output_file: Optional[str] = None,
    timeout: int = typer.Option(
        30000, help="Page load timeout in milliseconds"
    ),
):
    """
    Convert a webpage to Markdown.

    This function orchestrates the process of:
    1. Fetching a webpage using Playwright's browser automation
    2. Converting the HTML to Markdown using html2text
    3. Either displaying the result or saving it to a file

    Args:
        url: The URL of the webpage to convert
        output_file: Optional file path to save the Markdown output
        timeout: Maximum time in milliseconds to wait for page load
    """
    try:
        typer.echo(f"Converting {url} to Markdown...")

        # Run the async function to fetch the webpage content
        html_content = asyncio.run(fetch_webpage_content(url, timeout))

        # Convert the HTML content to Markdown
        markdown_content = convert_html_to_markdown(html_content)

        # Either save to file or print to console
        if output_file:
            try:
                with open(output_file, "w", encoding="utf-8") as f:
                    f.write(markdown_content)
                typer.echo(f"Markdown saved to {output_file}")
            except IOError as e:
                typer.secho(
                    f"Error writing to file {output_file}: {str(e)}",
                    fg=typer.colors.RED,
                    err=True,
                )
                sys.exit(1)
        else:
            typer.echo(markdown_content)

    except ValueError as e:
        typer.secho(f"Error: {str(e)}", fg=typer.colors.RED, err=True)
        sys.exit(1)
    except PlaywrightTimeoutError as e:
        typer.secho(f"Timeout Error: {str(e)}", fg=typer.colors.RED, err=True)
        typer.echo("Try increasing the timeout with --timeout option.")
        sys.exit(1)
    except Exception as e:
        typer.secho(f"Error: {str(e)}", fg=typer.colors.RED, err=True)
        sys.exit(1)


if __name__ == "__main__":
    # Start the Typer application
    app()
