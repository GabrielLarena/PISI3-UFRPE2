import streamlit as st
import pandas as pd
import io


#ler o dataset
df = pd.read_parquet("data/AnimeList2023.parquet")
df_user = pd.read_parquet("data/UserList2023.parquet")
df_userscore = pd.read_parquet("data/preprocessamento/UserAnimeList.parquet")

st.title('Pré-processamento dos dataframes')

st.write('Nosso primeiro passo será reduzir o número de colunas, pegando apenas as que são interessantes para a nossa análise.')
st.write("""
        ```
        animelist = df[df.Genres.notnull()][['anime_id','Name','Score','Genres','Synopsis','Type','Episodes'
        ,'Aired','Status','Producers','Licensors', 'Studios' ,'Source', 'Duration', 'Rating',
        'Rank','Popularity', 'Favorites', 'Scored By', 'Members']].copy()
        ```
""")

st.write('Além disso, iremos reduzir a quantidade dados, pegando apenas os animes que não possuem a linha Gender nula, assim como os usuários que possuem data de nascimento. Removeremos a coluna "Location" por não ser confiável')
#pegar apenas as colunas úteis
animelist = df[df.Genres.notnull()][['anime_id','Name','Score','Genres','Synopsis','Type','Episodes'
    ,'Aired','Status','Producers','Licensors', 'Studios' ,'Source', 'Duration', 'Rating',
    'Rank','Popularity', 'Favorites', 'Scored By', 'Members']].copy()

st.write('''
    ```
    user = df_user[df_user.Birthday.notnull()]
    user.drop(columns=["Location"], inplace=True)

    ```
''')
#selecionando apenas os usuários com data de nascimento cadastradas
user = df_user[df_user.Birthday.notnull()]

st.write('Iremos separar a coluna "Aired", que até o momento é uma string que possui o dia de início e fim do anime na televisão. Além disso, converteremos para um formato de data e não usaremos a data final')
st.write('''
    ```
    animelist[["Start", "End"]] = df['Aired'].str.split(' to ', n=1, expand=True)
    animelist["Start"] = pd.to_datetime(animelist["Start"], format='%b %d, %Y', errors='coerce')
    animelist.drop(columns=["End"], inplace=True)
    ```
''')

#transformar a string em dateformat e descartar o fim
animelist[["Start", "End"]] = df['Aired'].str.split(' to ', n=1, expand=True)
animelist["Start"] = pd.to_datetime(animelist["Start"], format='%b %d, %Y', errors='coerce')
animelist.drop(columns=["End"], inplace=True)

st.write('Além disso, iremos converter as colunas Birthday e Joined também para o formato de data')
st.write('''
    ```
    user["Birthday"] = pd.to_datetime(user["Birthday"], format='ISO8601', errors='coerce')
    user["Joined"] = pd.to_datetime(user["Joined"], format='ISO8601', errors='coerce')
    ```
''')

#convertendo para datetime
user["Birthday"] = pd.to_datetime(user["Birthday"], format='ISO8601', errors='coerce')
user["Joined"] = pd.to_datetime(user["Joined"], format='ISO8601', errors='coerce')

#renomeando colunas
animelist = animelist.rename(columns={"Name": "anime_title"})
df_userscore = df_userscore.rename(columns={"Anime Title": "anime_title"})
#transformar a string em float para obtermos os minutos

st.write('Agora iremos converter a coluna duration, que está em string')
st.write('''
    ```

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

    ```
''')

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

st.write('Separaremos a coluna Gender, que é uma string, em uma lista. Em seguida removeremos os valores nulos da coluna Start')

st.write('''
    ```
    animelist["Genres"] = animelist.Genres.str.split(", ").copy()
    animelist.dropna(subset=["Start"], inplace=True)


    ```
''')
#separar os generos em uma lista
animelist["Genres"] = animelist.Genres.str.split(", ").copy()

#remover os NULL
animelist.dropna(subset=["Start"], inplace=True)

st.write('Agora iremos remover todos os valores desconhecidos, que estão preenchidos como UNKNOWN. Para isso, iremos fazer um left join entre os dataframes')

st.write('''
    ```
    data = animelist.query('(anime_title=="UNKNOWN") or (Score=="UNKNOWN") or (Type=="UNKNOWN") or (Episodes=="UNKNOWN") or (Studios=="UNKNOWN") or (Rating=="UNKNOWN") or (Rank=="UNKNOWN")')
    merged_df = animelist.merge(data, on='anime_id', how='left', indicator=True).copy()
    animelist = merged_df[merged_df['_merge'] == 'left_only'].drop(columns='_merge').copy()
    ```
''')

#Remover os valores não conhecidos
data = animelist.query('(anime_title=="UNKNOWN") or (Score=="UNKNOWN") or (Type=="UNKNOWN") or (Episodes=="UNKNOWN") or (Studios=="UNKNOWN") or (Rating=="UNKNOWN") or (Rank=="UNKNOWN")')

#fazer o left join entre o dataframe principal e o dataframe onde os valores UNKNOWN foram removidos, obtendo apenas o dataset com todos os valores conhecidos
merged_df = animelist.merge(data, on='anime_id', how='left', indicator=True).copy()
animelist = merged_df[merged_df['_merge'] == 'left_only'].drop(columns='_merge').copy()

#removendo colunas vazias
animelist.drop(columns=["anime_title_y", 'Score_y', 'Genres_y', 'Synopsis_y', 'Type_y', 'Episodes_y', 'Aired_y', 
    'Status_y', 'Studios_y', 'Source_y', 'Duration_y', 'Rating_y', 'Rank_y', 'Popularity_y', 
    'Favorites_y', 'Scored By_y', 'Members_y', 'Start_y', 'Producers_y', 'Licensors_y'], inplace=True)

user.drop(columns=["Location"], inplace=True)

#renomeando as colunas por causa do left join
animelist = animelist.rename(columns=lambda x: x[:-2] if x.endswith('x') else x)

st.write('Por fim, iremos rever como os dados estão dispostos')

#mostrando novamente o cabeçalho
st.write(animelist.head())

st.write("Função info para a lista de animes")
animebuffer = io.StringIO()
animelist.info(buf=animebuffer)
s = animebuffer.getvalue()

#mostrando as informações de cada coluna
with st.expander("Info"):
    st.text(s)

st.write(user.head())

st.write("Função info para a lista de usuários")
userbuffer = io.StringIO()
user.info(buf=userbuffer)
s2 = userbuffer.getvalue()

#mostrando as informações de cada coluna
with st.expander("Info Users"):
    st.text(s2)

st.write(df_userscore.head())

st.write("Função info para a lista de usuários e notas")
userscorebuffer = io.StringIO()
df_userscore.info(buf=userscorebuffer)
s3 = userscorebuffer.getvalue()

#mostrando as informações de cada coluna
with st.expander("Info Userscore"):
    st.text(s3)

animelist.to_parquet("data/preprocessamento/AnimeList.parquet")
user.to_parquet("data/preprocessamento/UserList.parquet")
#df_userscore.to_parquet("data/preprocessamento/UserAnimeList2.parquet")
