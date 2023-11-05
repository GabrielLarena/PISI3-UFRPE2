import pandas as pd
import numpy as np
import matplotlib.pylab as plt
import seaborn as sns
plt.style.use("ggplot")

def genre_count(anime_genre):
    genre_list = []

    genre_splitted = []

    for i in anime_genre.index:
        for j in anime_genre[i].split(", "):
            genre_splitted.append(j)
            if j not in genre_list:
                genre_list.append(j)
    
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

    for i in anime_genre.index:
        if anime_genre[i].find('Comedy') > -1:
            for j in anime_genre[i].split(", "):
                if j != 'Comedy':
                    genres_with_comedy.append(j)
    genres_with_comedy_count = pd.Series(genres_with_comedy).value_counts().head(10).copy()

    fig, ax = plt.subplots()
    ax.pie(genres_with_comedy_count.tolist(), labels=genres_with_comedy_count.index.tolist(), autopct='%1.1f%%')
    #plt.title('Subgeneros que acompanham o genero Comédia')
    plt.savefig('foo2.png', bbox_inches='tight')

def season(animelist):
    anime_premiered = animelist[animelist.premiered.notnull()].premiered.copy()
    release_seasons = []

    for i in anime_premiered.index:
        release_seasons.append(anime_premiered[i].split(" ")[0])

    apc = pd.Series(release_seasons).value_counts().copy()
    anime_premiered_count = pd.DataFrame({'season':apc.index, 'premier':apc.values, 'order':[1,3,4,2]}).copy()
    anime_premiered_count.set_index('order', inplace=True)
    anime_premiered_count.sort_index(inplace=True)
    fig, ax = plt.subplots()
    ax.pie(anime_premiered_count['premier'], labels=anime_premiered_count['season'], autopct='%1.1f%%')
    #plt.title('Animes lançados por temporada')
    plt.savefig('foo3.png', bbox_inches='tight')

def broadcast(animelist):
    broadcast = [x.split(" at ")[0].strip() for x in animelist["broadcast"].astype("str")]
    broad_days = pd.Series(broadcast).value_counts()[2:9]
    df_broad_days = pd.DataFrame({'days':broad_days.index, 'broadcast':broad_days.values, 'index':[7,6,5,2,4,1,3]}).set_index('index').sort_index()
    fig, ax = plt.subplots()
    ax.pie(broad_days, labels=broad_days.index, autopct='%1.1f%%')
    #plt.title('Dia da semana que os animes são televisionados')
    plt.savefig('foo4.png', bbox_inches='tight')

def types(animelist):
    animetypes = animelist['type'].value_counts(dropna=False).copy()
    plt.figure(figsize=(8,5))
    sns.barplot(x=animetypes.index[:6] ,y=animetypes.values[:6])
    #plt.title('Types of Animes',fontsize=15)
    plt.xlabel('Tipo de anime')
    plt.ylabel('Quantidade')
    plt.savefig('foo5.png', bbox_inches='tight')

def source(animelist):
    animesources = animelist['source'].value_counts(dropna=False).copy()
    animesources = animesources[animesources.index != 'Unknown']
    plt.figure(figsize=(10,6))
    sns.barplot(x=animesources.index,y=animesources.values)
    plt.xticks(rotation=60)
    plt.xlabel('Baseado')
    #plt.title('Sources of Animes',fontsize=15)
    plt.savefig('foo6.png', bbox_inches='tight')

def rating(animelist):
    rating_counts = animelist.copy()
    #rating_counts['rating'] = animelist['rating'].copy()
    rating_counts['rating'].replace('Not available', np.nan, inplace=True)
    fig, ax = plt.subplots()
    ax.pie(rating_counts['rating'].value_counts(), labels=rating_counts['rating'].value_counts().index, autopct='%1.1f%%')
    plt.savefig('foo7.png', bbox_inches='tight')

def naosei(animelist):
    animelist.sort_values("rank", inplace = True)
    scatter_anime = animelist[animelist['rank'] != 0]
    sns.scatterplot(scatter_anime.head(100), x='rank', y='popularity', size='scored_by', sizes=(10, 200), hue='scored_by', hue_norm=(0, 7))
    plt.savefig('foo8.png', bbox_inches='tight')

df_anime = pd.read_parquet('dataset_files/AnimeList.parquet')
df_users = pd.read_parquet('dataset_files/UserList.parquet')

animelist = df_anime[df_anime.genre.notnull()][['anime_id','title','type','source','episodes','aired_string','duration','rating','score','scored_by','rank','popularity','premiered','studio','genre']].copy()
genre_count(animelist.genre)
genre_comedy(animelist.genre)
season(animelist)
broadcast(df_anime)
types(animelist)
source(animelist)
rating(animelist)
#naosei(animelist)

animelist.sort_values("rank", inplace = True)
scatter_anime = animelist[animelist['rank'] != 0]
sns.scatterplot(scatter_anime.head(100), x='rank', y='popularity', size='scored_by', sizes=(10, 200), hue='scored_by', hue_norm=(0, 7))
plt.savefig('foo8.png', bbox_inches='tight')