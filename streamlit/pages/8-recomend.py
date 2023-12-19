import streamlit as st
import pandas as pd
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import sigmoid_kernel

df_anime = pd.read_parquet("data/preprocessamento/AnimeList.parquet")
#df_anime = df_anime.drop(columns=['Status', 'Licensors', 'Popularity', 'Rank', 'Episodes', 'Aired', 'Producers', 'Studios', 'Source', 'Duration', 'Rating', 'Favorites'])

# retirar palavras simples
tfv = TfidfVectorizer(min_df=3, max_features=None,
      strip_accents='unicode', analyzer='word', token_pattern=r'\w{1,}',
      ngram_range=(1, 3),
      stop_words = 'english')

#NaNs with empty string
df_anime['Synopsis'] = df_anime['Synopsis'].fillna('')

#TF-IDF no texto de Synopsis
tfv_matrix = tfv.fit_transform(df_anime['Synopsis'])

#sigmoid kernel
sig = sigmoid_kernel(tfv_matrix, tfv_matrix)

#mapiamento reverso os indices com os titulos
indices = pd.Series(df_anime.index, index=df_anime['anime_title']).drop_duplicates()

st.title("Recomendar Anime")
anime = st.selectbox("Selecione o anime: ", df_anime['anime_title'])

def recomend(title, sig=sig):
    #index do anime escolhido
    idx = indices[title]

    # pairwise notas similares
    sig_scores = list(enumerate(sig[idx]))

    #sort animes
    sig_scores = sorted(sig_scores, key=lambda x: x[1], reverse=True)

    #notas dos 10 animes similares
    sig_scores = sig_scores[1:11]

    #indice dos anime
    anime_indices = [i[0] for i in sig_scores]

    #top 10 animes similares
    rec_df = df_anime.iloc[anime_indices]

    return rec_df


#print do anime selecionado
if anime:
    
    rec_df = recomend(anime)
    df_anime.set_index('anime_id', inplace=True)
    anime_info = df_anime.loc[df_anime["anime_title"] == anime]
    
    st.title(f"{anime_info.iloc[0]['anime_title']}")

    st.write(f"Sinopse: {anime_info.iloc[0]['Synopsis']}")

    st.write(f"Gêneros: {anime_info.iloc[0]['Genres']}")

    st.write(f"Data de lançamento: {anime_info.iloc[0]['Start']}")

    st.write(f"Tipo: {anime_info.iloc[0]['Type']}")

    st.write(f"Nota no MAL: {anime_info.iloc[0]['Score']}")

    st.write(f"Número de votos: {float(anime_info.iloc[0]['Scored By']):.0f}")

    #printing os animes recomendados 
    for i in range(10):
     st.header(f"{i+1}° Recomendação")

     st.write(f"Nome do anime: {rec_df.iloc[i]['anime_title']}")

     st.write(f"Sinopse: {rec_df.iloc[i]['Synopsis']}")

     st.write(f"Gêneros: {rec_df.iloc[i]['Genres']}")

     st.write(f"Data de lançamento: {rec_df.iloc[i]['Start']}")

     st.write(f"Tipo: {rec_df.iloc[i]['Type']}")

     st.write(f"Nota no MAL: {rec_df.iloc[i]['Score']}")

     st.write(f"Número de votos: {float(rec_df.iloc[i]['Scored By']):.0f}")
else:
    st.write("Selecione um anime")
