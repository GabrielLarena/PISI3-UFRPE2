import pandas as pd
import numpy as np
import streamlit as st
import plotly.express as px
import plotly.graph_objects as go

df_anime = pd.read_parquet("data/preprocessamento/AnimeList.parquet")
df_user = pd.read_parquet("data/preprocessamento/UserList.parquet")
df_userscore = pd.read_parquet("data/preprocessamento/UserAnimeList.parquet")

def barplot(df_anime):
    c1, c2 = st.columns([.2,.8])
    cols = ['Type', 'Source', 'Rating', 'Genres', 'Duration']
    series_col = c1.selectbox('Série*', options=cols, key='serie_1')
    #cols = [series_col, 'Members']
    cols.reverse()
    #df_plot = df_anime[cols]
    #fig = px.bar(df_anime, x='Type', y='Members')
    top_15 = df_anime.sort_values(by='Members', ascending=False).head(15)
    fig = px.bar(top_15, x='Type', y='Members', labels={'Members':'Number of Users', 'Type':'Tipo do anime'},color='Type', title='Top 15 Animes by Number of Users')
    st.plotly_chart(fig, use_container_width=True)


barplot(df_anime)
