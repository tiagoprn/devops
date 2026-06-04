# Pandas Cheatsheet

A concise reference covering the most important pandas methods, with one practical example each. All examples use astronomical data (`planets.csv` and `stars.csv`) for familiarity.

---

## 0. Install ipython and use it on the script to inspect/practice on a repl

```python

__import__('IPython').embed(user_ns=locals())

```

---

## 1. Loading & Inspecting

```python
import pandas as pd

df = pd.read_csv('planets.csv')       # Load CSV from file path

df.info()
# <class 'pandas.core.frame.DataFrame'>
# RangeIndex: 33 entries
# Columns: planet_id, star_id, planet_name, discovery_year ...
# dtypes, non-null counts shown per column

df.head()                             # First 5 rows as a table

print(df.shape)                       # (33, 12) → (rows, columns)

print(df.columns.tolist())
# ['planet_id', 'star_id', 'planet_name', 'discovery_year', ...]

df.describe()
# count, mean, std, min, 25%, 50%, 75%, max for all numeric columns
```

> NOTE: And here is how to **create a dataframe with "inline data"** (not importing a CSV):

```python

import pandas as pd

df = pd.DataFrame({
    'name':     ['Earth', 'Mars', 'Venus'],
    'mass':     [1.0, 0.107, 0.815],
    'habitable': [True, False, False]
})

```


---

## 2. Display Options

```python
pd.set_option('display.max_columns', None)  # Never truncate columns
pd.set_option('display.width', None)        # Never wrap lines

print(df.to_string())                       # Print every row, no truncation
```

---

## 3. Unique & Frequency

```python
df['detection_method'].unique()
# array(['Radial Velocity', 'Transit', 'Naked Eye', 'Telescopic'])

df['detection_method'].nunique()
# 4

df['detection_method'].value_counts()
# Radial Velocity    16
# Transit            11
# Naked Eye           4
# Telescopic          2
# Name: detection_method, dtype: int64

df['detection_method'].value_counts(dropna=False)  # Includes NaN rows
```

---

## 4. Boolean Filtering

```python
# Single condition
df[df['habitable_zone'] == 'Yes']

# AND — parentheses around EACH condition are REQUIRED
df[(df['habitable_zone'] == 'Yes') & (df['atmosphere_detected'] == 'Yes')]

# OR
df[(df['discovery_year'] < 2010) | (df['mass_earth'] > 100)]

# .query() — string-based, identical result, more readable
df.query('habitable_zone == "Yes" and atmosphere_detected == "Yes"')
df.query('discovery_year < 2010 or mass_earth > 100')

# Chain filters across steps
df_habitable = df[df['habitable_zone'] == 'Yes']
df_result = df_habitable[df_habitable['discovery_year'] > 2010]
```

---

## 5. Groupby & Aggregation

```python
# Single aggregation
df.groupby('detection_method').agg(
    total=('planet_id', 'count')
)

# Multiple aggregations in one call (named aggregation syntax)
df.groupby('detection_method').agg(
    total=('planet_id', 'count'),
    avg_mass=('mass_earth', 'mean'),
    max_mass=('mass_earth', 'max'),
    min_radius=('radius_earth', 'min')
)

# Aggregating a Yes/No column — convert to bool first, then use 'any'
df['is_habitable'] = df['habitable_zone'] == 'Yes'
df.groupby('star_id').agg(
    has_habitable=('is_habitable', 'any')
)

# Alternative — lambda inside agg (no extra column needed)
df.groupby('star_id').agg(
    has_habitable=('habitable_zone', lambda x: 'Yes' if (x == 'Yes').any() else 'No')
)
```

---

## 6. Sorting

```python
# Single column, ascending (default)
df.sort_values('mass_earth')

# Single column, descending
df.sort_values('mass_earth', ascending=False)

# Multiple columns, different directions
# Positional mapping: col1 → False, col2 → True
df.sort_values(
    by=['total_habitable_planets', 'distance_ly'],
    ascending=[False, True]
)
```

---

## 7. Merge (Join)

```python
# Inner join — only rows matching in both DataFrames (default)
pd.merge(df_planets, df_stars, on='star_id')
pd.merge(df_planets, df_stars, on='star_id', how='inner')  # explicit

# Left join — all rows from df_planets, NaN where no star matches
pd.merge(df_planets, df_stars, on='star_id', how='left')

# Different key column names in each DataFrame
pd.merge(df_planets, df_stars, left_on='star_id', right_on='id')

# Detect unmatched rows after left join
merged = pd.merge(df_planets, df_stars, on='star_id', how='left')
print(merged['name'].isna().sum())  # Count planets with no matching star
```

| Join Type | Keeps | Use When |
|-----------|-------|----------|
| `inner` | Only matching rows | You need complete data from both sides |
| `left` | All rows from left DataFrame | You want to detect missing matches |
| `right` | All rows from right DataFrame | Rare; usually restructure to use left |
| `outer` | All rows from both | Full reconciliation needed |

---

## 8. Filter on Aggregated Result

```python
# WRONG — filters rows before grouping (different question)
df[df['habitable_zone'] == 'Yes'].groupby('star_id').agg(total=('planet_id', 'count'))

# CORRECT — aggregate first, then filter on the aggregated column
result = df.groupby('star_id').agg(total_planets=('planet_id', 'count'))
result[result['total_planets'] > 2]        # Boolean filter
result.query('total_planets > 2')          # .query() equivalent
```

---

## 9. Rename & Select Columns

```python
# Rename columns to avoid ambiguity after merge
df = df.rename(columns={
    'name': 'star_name',
    'classification': 'star_classification'
})

# Select a subset of columns
df[['planet_name', 'star_name', 'detection_method', 'star_classification']]
```

---

## 10. Find Max / Min Row

```python
# Top row after sorting — simple, requires pre-sorting
df.sort_values('total_planets', ascending=False).head(1)

# idxmax() — explicit and self-documenting, works without pre-sorting
df.loc[df['total_planets'].idxmax()]   # Returns the full row
df.loc[df['mass_earth'].idxmin()]      # Row with minimum mass

# Just the index label of the max (useful after groupby)
df['total_planets'].idxmax()           # e.g. 'S013'
```

---

## 11. Iterate Rows (Formatted Output)

```python
# iterrows() — yields (index, Series) tuples
for _, row in df.iterrows():
    print(
        f"{row['name']} is a {row['classification']} located "
        f"{row['distance_ly']} ly away, with {row['total_habitable_planets']} "
        f"habitable planet(s) out of {row['total_planets']} total."
    )
# Output:
# TRAPPIST-1 is a Ultra-Cool Red Dwarf located 40.66 ly away, with 4 habitable planet(s) out of 7 total.
# Sun is a Yellow Dwarf located 0.0 ly away, with 2 habitable planet(s) out of 8 total.

# apply() with axis=1 — vectorized alternative
df.apply(
    lambda row: f"{row['name']} — {row['total_planets']} planets",
    axis=1
)
```

---

## 12. Null Handling

```python
df['name'].isna().sum()                      # Count nulls: 3

df.dropna(subset=['name'])                   # Drop rows where 'name' is NaN

df['atmosphere_detected'].fillna('Unknown')  # Replace NaN with 'Unknown'
```

---

## ⚠️ Common Pitfalls

### Pitfall 1 — Missing parentheses in multi-condition filter
```python
# ❌ Raises ValueError — & binds tighter than ==
df[df['a'] == 'Yes' & df['b'] > 10]

# ✅ Always wrap each condition in parentheses
df[(df['a'] == 'Yes') & (df['b'] > 10)]
```

### Pitfall 2 — Filtering before groupby for group-level conditions
```python
# ❌ Wrong — filters individual rows, not groups
df[df['habitable_zone'] == 'Yes'].groupby('star_id').agg(total=('planet_id','count'))

# ✅ Correct — aggregate first, then filter the result
result = df.groupby('star_id').agg(total=('planet_id', 'count'))
result[result['total'] > 2]
```

### Pitfall 3 — Accessing groupby key as a column (it becomes the index)
```python
result = df.groupby('star_id').agg(total=('planet_id', 'count'))

result['star_id']          # ❌ KeyError — star_id is now the index
result.index.to_list()     # ✅ Correct way to access groupby key values
```

### Pitfall 4 — Overwriting original DataFrames mid-script
```python
# ❌ Dangerous — re-running the cell will fail or produce wrong results
df_stars = pd.merge(df_stars, df_extra, on='star_id')

# ✅ Always use a new variable name
df_stars_enriched = pd.merge(df_stars, df_extra, on='star_id')
```

---

*Generated during DataArt interview preparation — pandas exercises using planets.csv and stars.csv.*
