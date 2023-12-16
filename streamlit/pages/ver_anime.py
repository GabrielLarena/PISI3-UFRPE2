import streamlit as st
import pandas as pd

df_anime = pd.read_parquet("data/preprocessamento/AnimeList.parquet")
df_anime.drop(columns=["Unnamed: 0"], inplace=True)

st.title("Consultar Anime")
anime = st.selectbox("Selecione o anime: ", df_anime['Name'])

if anime:
    df_anime.set_index('anime_id', inplace=True)
    anime_info = df_anime.loc[df_anime["Name"] == anime]
    
    st.title(f"{anime_info.iloc[0]['Name']}")
    st.write(f"Classificação indicativa: {anime_info.iloc[0]['Rating']}")

    st.write(f"Sinopse: {anime_info.iloc[0]['Synopsis']}")

    st.write(f"Gêneros: {anime_info.iloc[0]['Genres']}")

    st.write(f"Ranking Melhor Nota: {int(anime_info.iloc[0]['Rank'])}° Lugar")

    st.write(f"Ranking Popularidade: {anime_info.iloc[0]['Popularity']}° Lugar")

    st.write(f"Data de lançamento: {anime_info.iloc[0]['Start']}")

    st.write(f"Duração: {int(anime_info.iloc[0]['Duration'])} minutos")

    st.write(f"Tipo: {anime_info.iloc[0]['Type']}")

    st.write(f"Nota no MAL: {anime_info.iloc[0]['Score']}")

    st.write(f"Número de votos: {int(anime_info.iloc[0]['Scored By'])}")
else:
    st.write("Selecione um anime")