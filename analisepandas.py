import pandas as pd
import numpy as np
import matplotlib.pylab as plt
import seaborn as sns
import datetime
plt.style.use("ggplot")

def genre_count(anime_genre):
    genre_list = []

    genre_splitted = []
    #Tem um loop que percorre cada linha e separa elas baseado na vírgula. 
    #O loop armazena duas listas, uma com todas as ocorrências do genero genre_splitted
    #A outra genre_list armazena os generos diferentes.

    for i in anime_genre.index:
        for j in anime_genre[i].split(", "):#percorremos cada linha e dividimos os generos a cada virgula
            genre_splitted.append(j) #pegamos cada genero
            if j not in genre_list:
                genre_list.append(j) #pegamos os generos para saber quais existem
    #Por fim, pegamos as quantidades de generos e plotamos um gráfico usando o indice e os valores

    anime_genres_count = pd.Series(genre_splitted).value_counts().copy()
    plt.figure(figsize=(15,10))
    sns.barplot(x=anime_genres_count.index.tolist(), y=anime_genres_count.tolist())
    plt.xlabel('Gênero')
    plt.ylabel('Animes produzidos')
    #plt.title('Gêneros mais populares') 
    plt.xticks(rotation= 75) 
    plt.savefig('foo.png', bbox_inches='tight')

def genre_comedy(anime_genre):
    genres_with_comedy = []
    #O propósito é o mesmo da função anterior, um loop que percorre as linhas armazenando valores em uma lista.
    #Porém, agora só iremos armazenar os generos que acompanham o genero comedy.

    for i in anime_genre.index:
        if anime_genre[i].find('Comedy') > -1: #localizamos as linhas que possuem o genero comedy
            for j in anime_genre[i].split(", "): #pegamos os generos
                if j != 'Comedy':
                    genres_with_comedy.append(j) #adicionamos os generos que acompanham
    genres_with_comedy_count = pd.Series(genres_with_comedy).value_counts().head(10).copy()
    #criamos o plot desses generos
    fig, ax = plt.subplots()
    ax.pie(genres_with_comedy_count.tolist(), labels=genres_with_comedy_count.index.tolist(), autopct='%1.1f%%')
    #plt.title('Subgeneros que acompanham o genero Comédia')
    plt.savefig('foo2.png', bbox_inches='tight')

def season(animelist):
    anime_premiered = animelist[animelist.premiered.notnull()].premiered.copy() #pega os valores não nulos
    release_seasons = []

    for i in anime_premiered.index:
        release_seasons.append(anime_premiered[i].split(" ")[0]) #pega apenas a estação, sem pegar o ano
    #cria os plots
    apc = pd.Series(release_seasons).value_counts().copy()
    anime_premiered_count = pd.DataFrame({'season':apc.index, 'premier':apc.values, 'order':[1,3,4,2]}).copy()
    anime_premiered_count.set_index('order', inplace=True)
    anime_premiered_count.sort_index(inplace=True)
    fig, ax = plt.subplots()
    ax.pie(anime_premiered_count['premier'], labels=anime_premiered_count['season'], autopct='%1.1f%%')
    #plt.title('Animes lançados por temporada')
    plt.savefig('foo3.png', bbox_inches='tight')

def broadcast(animelist):
    broadcast = [x.split(" at ")[0].strip() for x in animelist["broadcast"].astype("str")] #separa o dia
    broad_days = pd.Series(broadcast).value_counts()[2:9] #pega os dias da semana
    df_broad_days = pd.DataFrame({'days':broad_days.index, 'broadcast':broad_days.values, 'index':[7,6,5,2,4,1,3]}).set_index('index').sort_index()
    fig, ax = plt.subplots()
    #faz o plot
    ax.pie(broad_days, labels=broad_days.index, autopct='%1.1f%%')
    #plt.title('Dia da semana que os animes são televisionados')
    plt.savefig('foo4.png', bbox_inches='tight')

def types(animelist):
    animetypes = animelist['type'].value_counts(dropna=False).copy() #pega os valores
    plt.figure(figsize=(8,5))#plota o gráfico
    sns.barplot(x=animetypes.index[:6] ,y=animetypes.values[:6])
    #plt.title('Types of Animes',fontsize=15)
    plt.xlabel('Tipo de anime')
    plt.ylabel('Quantidade')
    plt.savefig('foo5.png', bbox_inches='tight')

def source(animelist):
    animesources = animelist['source'].value_counts(dropna=False).copy()
    animesources = animesources[animesources.index != 'Unknown'] #desconsidera os não-conhecidos
    plt.figure(figsize=(10,6)) #plot do gráfico
    sns.barplot(x=animesources.index,y=animesources.values)
    plt.xticks(rotation=60)
    plt.xlabel('Baseado')
    #plt.title('Sources of Animes',fontsize=15)
    plt.savefig('foo6.png', bbox_inches='tight')

def rating(animelist):
    rating_counts = animelist.copy()
    #rating_counts['rating'] = animelist['rating'].copy()
    rating_counts['rating'].replace('Not available', np.nan, inplace=True) #atribui valores nan para os não disponiveis
    fig, ax = plt.subplots()#plot do gráfico
    ax.pie(rating_counts['rating'].value_counts(), labels=rating_counts['rating'].value_counts().index, autopct='%1.1f%%')
    plt.savefig('foo7.png', bbox_inches='tight')

def scatter(animelist):
    animelist.sort_values("rank", inplace = True)#pega os valores em ordem crescente da coluna rank
    scatter_anime = animelist[animelist['rank'] != 0] #desconsidera valores 0 na coluna rank
    #cria o plot com x sendo o rank, o y sendo a popularidade, o tamanho dos circulos sendo a quantidade de votos (scored_by).
    sns.scatterplot(scatter_anime.head(100), x='rank', y='popularity', size='scored_by', sizes=(10, 200), hue='scored_by', hue_norm=(0, 7)) 
    plt.savefig('foo8.png', bbox_inches='tight')


def genre_dist(df):
    """ Gera um pie plot a partir dos valores gender do dataframe."""
    df['gender'].value_counts().plot.pie(autopct='%1.1f%%', 
                                         startangle=120,
                                         xlabel='',
                                         ylabel='')
    plt.show()


def toDate(column):
    """ Converte coluna para formato data."""
    return pd.to_datetime(column, errors = 'coerce')


def spent_box(df):
    """ Plota um gráfico boxplot com a distribuição de tempo (time_spent) de consumo
        em relação a gênero (gender)
    """

    fig, ax = plt.subplots(nrows=1, ncols=1,figsize=(5, 6))
    sns.boxplot(x="gender", 
                y="user_days_spent_watching",
                data=df,
                palette="Set2",
                )
    plt.ylabel('spent')
    ax.set_ylim([0, 300])
    plt.show()


def drop_out(df):
    """ Dropa outliers no df"""
    df.drop(df[df.spent>1000].index, inplace=True)
    df.drop(df[df.age>80].index, inplace=True)
    df.drop(df[df.age<0].index, inplace=True)


def convert_age(column):
    age = []

    for x in column:
        age.append(round((datetime.datetime.now()-x).days/365.25,1))
    return age

def spent_scatter(df):
    """ Gera um scatterplot com a relação idade/tempo consumo e identificando por gênero. """
    
    birthdays = toDate(df['birth_date'])
    age = convert_age(birthdays)
    temp = {'age': age, 'gender':df.gender, 'spent': df.user_days_spent_watching}
    age_spent = pd.DataFrame(temp, columns=['age', 'gender', 'spent'])
    drop_out(age_spent)
    

    age_spent.plot(kind='scatter', 
                    x='age', y='spent', alpha=0.5, 
                    figsize = (12,8),
                    color=["r" if each =="Female" else "b" for each in age_spent.gender])
    plt.show()


def main():
    #Chamamos os dois dataframes utilizados, AnimeList e UserList e armazenamos em duas variáveis
    df_anime = pd.read_parquet('dataset_files/AnimeList.parquet')
    df_users = pd.read_parquet('dataset_files/UserList.parquet')

    #desconsideramos qualquer linha que tenha o genero vazio e pegamos as colunas escolhidas para analise
    animelist = df_anime[df_anime.genre.notnull()][['anime_id','title','type','source','episodes','aired_string','duration','rating','score','scored_by','rank','popularity','premiered','studio','genre']].copy()

    # genre_dist(df_users)

    # spent_box(df_users)

    # spent_scatter(df_users)

    # #chamamos a função genre_count, que vai contar quantos generos possui na coluna genre.
    # genre_count(animelist.genre)
    # #nós chamamos a função genre_comedy, que vai verificar quantos generos acompanham o genero comedy
    # genre_comedy(animelist.genre)
    # #a função season que pega a coluna premiered e separa as estações do ano e plota um gráfico com a quantidades
    # season(animelist)
    # #função broadcast faz o mesmo q a anterior mas para os dias da semana
    # broadcast(df_anime)
    # #função types que plota um gráfico usando a coluna "types" com a quantia dos tipos de AnimeList
    # types(animelist)
    # #função source que faz o mesmo que a anterior mas para a coluna "source"
    # source(animelist)
    # #função rating que verifica para qual faixa etária aquele anime é destinado
    # rating(animelist)
    # #função scatter que cria um scatter plot usando o rank, a popularidade e a quantia de votos. 
    # scatter(df_anime)

main()