import io
import streamlit as st
import pandas as pd

df_anime = pd.read_parquet("data/AnimeList2023.parquet")
df_user = pd.read_parquet("data/UserList2023.parquet")
df_userscore = pd.read_parquet("data/preprocessamento/UserAnimeList.parquet")

st.title("Dataset Original")
st.markdown("Aqui se encontra os dataframes antes do pré-processamento")

with st.expander("Descrição das colunas"):
    st.markdown('''
        # Colunas AnimeList

        * anime_id: Registro do anime na base de dados.
        * Name: Nome do anime
        * English Name: Nome do anime em inglês
        * Other Name: Nome do anime em japonês
        * Score: Nota média
        * Genres: Gêneros do anime
        * Synopsis: Descrição do anime
        * type: Tipo do anime
        * episodes: N° de Episódios
        * aired: Em que período foi televisionado (String)
        * premiered: Estação do ano em que foi lançado
        * status: Se está sendo televisionado (String)
        * producer: Empresas responsáveis por ajudar na produção do anime
        * licensor: Empresas responsáveis pelo licenciamento do anime
        * studios: Estúdio responsável pelo desenvolvimento do anime
        * source: Em quê o anime foi baseado
        * duration: Duração média de cada episódio (String)
        * rating: Faixa etária apropriada para o anime
        * rank: Posição no Ranking de maior nota
        * popularity: Ranking de mais popular
        * favorites: Quantas pessoas favoritaram o anime
        * scored_by: Quantos votos foram dados para a nota
        * members: Quantas pessoas se inscreveram para receber informações do anime
        * image url: Endereço eletrônico da capa do anime

        #Colunas UserList

        * Mal ID: Registro do usuário na base de dados.
        * Username: Apelido do usuário
        * Gender: Genero do usuário
        * Birthday: Data de nascimento do usuário
        * Location: Local de moradia do usuário
        * Joined: Data de criação de conta
        * Days Watched: Quantos dias o usuário gastou assistindo animes
        * Mean Score: Média das notas do usuário
        * Watching: Quantos animes o usuário está assistindo agora
        * Completed: Quantos animes o usuário assistiu até o fim
        * On Hold: Quantos animes o usuário pausou
        * Dropped: Quantos animes o usuário abandonou
        * Plan to Watch: Quantos animes usuário pretende assistir
        * Total Entries:
        * Rewatched: Quantos animes usuário reassistiu
        * Episodes Watched: Quantos episódios usuário assistiu

        #Colunas UserScore

        * user_id: Registro do usuário na base de dados.
        * Username: Apelido do usuário
        * anime_id: Registro do anime na base de dados.
        * anime_title: Nome do anime
        * rating: Nota do usuário para o anime
''')

st.write("Cabeçalho da lista de animes")
st.write(df_anime.head())

st.write("Cabeçalho da lista de Usuários")
st.write(df_user.head())

st.write("Cabeçalho da lista de Usuário sobre anime")
st.write(df_userscore.head())

st.write("Função info para lista de animes")
animebuffer = io.StringIO()
df_anime.info(buf=animebuffer)
s = animebuffer.getvalue()

with st.expander("Info Animes"):
    st.text(s)

st.write("Função info para lista de Usuários")
userbuffer = io.StringIO()
df_user.info(buf=userbuffer)
s2 = userbuffer.getvalue()

with st.expander("Info Users"):
    st.text(s2)

st.write("Função info para lista de Usuários e Animes")
userscorebuffer = io.StringIO()
df_userscore.info(buf=userscorebuffer)
s3 = userscorebuffer.getvalue()

with st.expander("Info Animes"):
    st.text(s3)
