import streamlit as st
import pandas as pd
import plotly.express as px

df_anime = pd.read_parquet("data/preprocessamento/AnimeList.parquet")
df_user = pd.read_parquet("data/preprocessamento/UserList.parquet")
df_userscore = pd.read_parquet("data/preprocessamento/UserAnimeList.parquet")

def boxplot(df_user):
    st.markdown('### Informações dos usuários', unsafe_allow_html=True)
    #df['birth_date'] = pd.to_datetime(df_user['Birthday'])
    current_year = pd.Timestamp.now().year
    df_user['age'] = current_year - df_user['Birthday'].dt.year
    df_user['age_account'] = current_year - df_user['Joined'].dt.year
    c1, c2 = st.columns([.3,.7])
    cols = ['age', 'Gender']
    cols.reverse()
    serie_col = c1.selectbox('Série*', options=cols, key='serie_2')
    if serie_col == 'Gender':
        fig = px.bar(df_user['Gender'], labels={'x': 'Genero', 'y': 'Numero de usuários'})
    else:
        df_plot = df_user[cols]
        fig = px.box(df_plot,x=cols[0],y=cols[1])
        fig.update_layout(yaxis_range=[0, 80])

    st.plotly_chart(fig, use_container_width=True)

st.title("Consultar Anime")
anime = st.selectbox("Selecione o anime: ", df_anime['anime_title'])

if anime:
    df_anime.set_index('anime_id', inplace=True)
    anime_info = df_anime.loc[df_anime["anime_title"] == anime].copy()

    st.title(f"{anime_info.iloc[0]['anime_title']}")
    st.write(f"Classificação indicativa: {anime_info.iloc[0]['Rating']}")

    st.write(f"Sinopse: {anime_info.iloc[0]['Synopsis']}")

    st.write(f"Gêneros: {anime_info.iloc[0]['Genres']}")

    st.write(f"Ranking Melhor Nota: {float(anime_info.iloc[0]['Rank']):.0f}° Lugar")

    st.write(f"Ranking Popularidade: {anime_info.iloc[0]['Popularity']}° Lugar")

    st.write(f"Data de lançamento: {anime_info.iloc[0]['Start']}")

    st.write(f"Duração: {anime_info.iloc[0]['Duration']} minutos")

    st.write(f"Tipo: {anime_info.iloc[0]['Type']}")

    st.write(f"Nota no MAL: {anime_info.iloc[0]['Score']}")

    st.write(f"Número de votos: {float(anime_info.iloc[0]['Scored By']):.0f}")

    #Selecionando apenas os usuários que assistem esse anime
    userscore = df_userscore[df_userscore["anime_title"] == anime_info.iloc[0]['anime_title']]
    #selecionando as informações dos usuários que assistem o anime
    usersinfo = pd.merge(df_user, userscore, how='inner', on=['Username'])
    #criando um boxplot pra cada usuário
    boxplot(usersinfo)

else:
    st.write("Selecione um anime")
