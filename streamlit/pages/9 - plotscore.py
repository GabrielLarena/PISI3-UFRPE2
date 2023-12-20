import pandas as pd
import numpy as np
import streamlit as st
import plotly.express as px
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.graph_objects as go

df_anime = pd.read_parquet("data/preprocessamento/AnimeList.parquet")

st.title("Heatmap")

# Arrendodando as notas
df_anime['Score'] = df_anime['Score'].astype(float).round()

# tirando os 0s
new_df = df_anime[df_anime['Score'] != 0]

#heatmap
heatmap_data = new_df.groupby(['Genre', 'Score']).size().unstack(fill_value=0)
plt.figure(figsize=(43, 10))
sns.heatmap(heatmap_data, cmap='viridis', annot=True, fmt='d', linewidth=1, linecolor='white')

plt.xlabel('Nota')
plt.ylabel("genero")
plt.title(f'Heatmap')

plt.show()