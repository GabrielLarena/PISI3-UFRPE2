import streamlit as st
import pandas as pd
import io

#ler o dataset
df = pd.read_parquet("data/AnimeList2023.parquet")
df_user = pd.read_parquet("data/UserList2023.parquet")
#df_userscore = pd.read_parquet("data/UserAnimeList2023.parquet")

#pegar apenas as colunas úteis
animelist = df[df.Genres.notnull()][['anime_id','Name','Score','Genres','Synopsis','Type','Episodes'
    ,'Aired','Status','Producers','Licensors', 'Studios' ,'Source', 'Duration', 'Rating',
    'Rank','Popularity', 'Favorites', 'Scored By', 'Members']].copy()

user = df_user[df_user.Birthday.notnull()]

#transformar a string em dateformat
animelist[["Start", "End"]] = df['Aired'].str.split(' to ', n=1, expand=True)

animelist["Start"] = pd.to_datetime(animelist["Start"], format='%b %d, %Y', errors='coerce')
animelist.drop(columns=["End"], inplace=True)

user["Birthday"] = pd.to_datetime(user["Birthday"], format='ISO8601', errors='coerce')
user["Joined"] = pd.to_datetime(user["Joined"], format='ISO8601', errors='coerce')


#transformar a string em float para obtermos os minutos
def toMinutes(column):
    hours = 0
    minutes = 0
    part = column.split()
    if 'hr' in part:
        hours = int(part[0])
        if 'min' in part:
            minutes = int(part[2])
        return (hours * 60) + minutes
    elif 'min' in column:
        return int(part[0])
    return hours + minutes

animelist["Duration"] = animelist["Duration"].apply(toMinutes)

#separar os generos em uma lista
animelist["Genres"] = animelist.Genres.str.split(", ").copy()

#remover os NULL
animelist.dropna(subset=["Start"], inplace=True)

#Remover os valores não conhecidos
with st.expander("UNKNOWN"):
    data = animelist.query('(Name=="UNKNOWN") or (Score=="UNKNOWN") or (Type=="UNKNOWN") or (Episodes=="UNKNOWN") or (Studios=="UNKNOWN") or (Rating=="UNKNOWN") or (Rank=="UNKNOWN")')
    st.write(len(data['Name']))

#fazer o left join entre o dataframe principal e o dataframe onde os valores UNKNOWN foram removidos, obtendo apenas o dataset com todos os valores conhecidos
merged_df = animelist.merge(data, on='anime_id', how='left', indicator=True).copy()
animelist = merged_df[merged_df['_merge'] == 'left_only'].drop(columns='_merge').copy()

#removendo colunas vazias
animelist.drop(columns=["Name_y", 'Score_y', 'Genres_y', 'Synopsis_y', 'Type_y', 'Episodes_y', 'Aired_y', 
    'Status_y', 'Studios_y', 'Source_y', 'Duration_y', 'Rating_y', 'Rank_y', 'Popularity_y', 
    'Favorites_y', 'Scored By_y', 'Members_y', 'Start_y', 'Producers_y', 'Licensors_y'], inplace=True)

#Converter rank e popularidade pra int
#animelist['Popularity'] = pd.to_numeric(animelist['Popularity'], downcast='integer')
#animelist['Rank'] = pd.to_numeric(animelist['Rank'], downcast='integer')

user.drop(columns=["Location"], inplace=True)

#renomeando as colunas por causa do left join
animelist = animelist.rename(columns=lambda x: x[:-2] if x.endswith('x') else x)

#mostrando novamente o cabeçalho
st.write(animelist.head())

st.write("Função info")
buffer = io.StringIO()
animelist.info(buf=buffer)
s = buffer.getvalue()

#mostrando as informações de cada coluna
with st.expander("Info"):
    st.text(s)

st.write(user.head())

st.write("Função info para usuários")
buffer2 = io.StringIO()
user.info(buf=buffer2)
s2 = buffer2.getvalue()

#mostrando as informações de cada coluna
with st.expander("Info Users"):
    st.text(s2)

animelist.to_parquet("data/preprocessamento/AnimeList.parquet")
user.to_parquet("data/preprocessamento/UserList.parquet")
