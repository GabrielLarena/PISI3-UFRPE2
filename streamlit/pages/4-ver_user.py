import streamlit as st
import pandas as pd
from wordcloud import WordCloud
import matplotlib.pyplot as plt
from  itertools import chain
import plotly.express as px

df_user = pd.read_parquet("data/preprocessamento/UserList.parquet")
df_userscore = pd.read_parquet("data/preprocessamento/UserAnimeList.parquet")
df_anime = pd.read_parquet("data/preprocessamento/AnimeList.parquet")

def wc(df):
    s = pd.Series(list(chain.from_iterable(df['Genres'])))    
    wordcloud = WordCloud(background_color='white')
    wordcloud.generate_from_frequencies(frequencies=s.value_counts())
    plt.imshow(wordcloud, interpolation='bilinear')
    plt.axis("off")
    st.pyplot(plt.gcf())

def barplots(df):
    c1, c2 = st.columns([.2,.8])
    s = pd.Series(list(chain.from_iterable(df['Genres'])))
    df_genre = s.value_counts()
    cols = ['Type', 'Source', 'Rating', 'Genres', 'Duration']
    series_col = c1.selectbox('Série*', options=cols, key='serie_1')
    if series_col == 'Genres':
        fig = px.bar(df_genre, labels={'x': 'Genero', 'y': 'Numero de Animes'})
    elif series_col == 'Duration':
        fig = px.histogram(df[series_col].value_counts(), x=df[series_col].value_counts().index, y=df[series_col].value_counts().values)
    else:
        fig = px.bar(df[series_col].value_counts(), labels={'x': "Numero de animes", 'y': series_col})
    c2.plotly_chart(fig, use_container_width=True)

st.title("Consultar usuário")
user = st.selectbox("Selecione o Usuário: ", df_user['Username'])

if user:
    df_user.set_index('Mal ID', inplace=True)
    user_info = df_user.loc[df_user["Username"] == user]
    
    st.title(f"{user_info.iloc[0]['Username']}")
    st.write(f"Genero: {user_info.iloc[0]['Gender']}")

    st.write(f"Data de Nascimento: {user_info.iloc[0]['Birthday']}")

    st.write(f"Data de criação da conta: {user_info.iloc[0]['Joined']}")

    st.write(f"Quanto tempo em horas assistindo anime: {(user_info.iloc[0]['Days Watched'] * 24):.0f} horas")

    st.write(f"Média de nota: {user_info.iloc[0]['Mean Score']}")

    st.write(f"Animes Completados: {(user_info.iloc[0]['Completed']):.0f}")

    st.write(f"Animes abandonados: {(user_info.iloc[0]['Dropped']):.0f}")

    st.write(f"Número de episódios assistidos: {(user_info.iloc[0]['Episodes Watched']):.0f}")

    userinfo = df_userscore[df_userscore["Username"] == user_info.iloc[0]['Username']]
    animeinfo = pd.merge(df_anime, userinfo, how='inner', on=['anime_title'])
    wc(animeinfo)
    barplots(animeinfo)

else:
    st.write("Selecione um usuário")
