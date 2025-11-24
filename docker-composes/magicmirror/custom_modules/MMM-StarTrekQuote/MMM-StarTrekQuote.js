/* MagicMirror
 * Module: MMM-StarTrekQuote
 */

Module.register("MMM-StarTrekQuote", {
  defaults: {
    updateInterval: 60 * 60 * 1000 // 1 hour (in ms)
  },

  start: function() {
    this.quote = "Loading...";
    this.getQuote();
    setInterval(() => {
      this.getQuote();
    }, this.config.updateInterval);
  },

  getQuote: function() {
    var self = this;
    var url = "https://power-plugins.com/api/flipsum/ipsum/star-trek?paragraphs=1&start_with_fixed=0";
    var req = new XMLHttpRequest();
    req.open("GET", url, true);
    req.onreadystatechange = function() {
      if (this.readyState === 4 && this.status === 200) {
        // The API returns a JSON array with one paragraph as a string.
        try {
          var result = JSON.parse(this.responseText);
          // Extract just the first sentence from the returned paragraph.
          if (result && Array.isArray(result) && result.length > 0) {
            // Split paragraph into sentences
            var sentences = result[0].match(/[^\.!\?]+[\.!\?]+/g);
            if (sentences && sentences.length > 0) {
              self.quote = sentences[0].trim();
            } else {
              self.quote = result[0].trim();
            }
          } else {
            self.quote = "No quote found.";
          }
        } catch (err) {
          self.quote = "API Error";
        }
        self.updateDom();
      }
    };
    req.send();
  },

  getDom: function() {
    var wrapper = document.createElement("div");
    wrapper.innerHTML = `<em>"${this.quote}"</em>`;
    wrapper.style.fontSize = "1.2em";
    wrapper.style.textAlign = "center";
    return wrapper;
  }
});

