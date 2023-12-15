import io
import streamlit as st
import pandas as pd

df = pd.read_parquet("data/AnimeList2023.parquet")

st.title("Dataset Original")
st.markdown(""" 
    Aqui se encontra o dataset antes do pré-processamento.
""")

with st.expander("Descrição das colunas"):
    st.markdown('''
        # Colunas

        * anime_id: Registro do anime na base de dados.
        * title: Nome do anime
        * title_english: Nome do anime em inglês
        * title_japanese: Nome do anime em japonês
        * title_synonyms: Sinônimo do nome do anime
        * image_url: Endereço eletrônico da capa do anime
        * type: Tipo do anime
        * source: Em quê o anime foi baseado
        * episodes: N° de Episódios
        * status: Se está sendo televisionado (String)
        * airing: Se está sendo televisionado (Booleano)
        * aired_string: Em que período foi televisionado (Em texto)
        * aired: Em que período foi televisionado (Em dicionário)
        * duration: Duração média de cada episódio
        * rating: Faixa etária apropriada para o anime
        * score: Nota média
        * scored_by: Quantos votos foram dados para a nota
        * rank: Posição no Ranking de maior nota
        * popularity: Ranking de mais popular
        * members: Quantas pessoas se inscreveram para receber informações do anime
        * favorites: Quantas pessoas favoritaram o anime
        * background: Detalhes sobre produção
        * premiered: Estação do ano em que foi lançado
        * broadcast: Dia da semana em que foi televisionado
        * related: Animes relacionados
        * producer: Empresas responsáveis por ajudar na produção do anime
        * licensor: Empresas responsáveis pelo licenciamento do anime
        * studio: Estúdio responsável pelo desenvolvimento do anime
        * genre: Gêneros do anime
        * opening_theme: Música de abertura
        * ending_theme: Música de fechamento

''')
st.write("Cabeçalho")
st.write(df.head())


st.write("Função info")
buffer = io.StringIO()
df.info(buf=buffer)
s = buffer.getvalue()

with st.expander("Info"):
    st.text(s)
