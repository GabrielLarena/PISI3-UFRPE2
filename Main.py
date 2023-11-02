import pandas as pd
from Maintenance import *
from graphics import *
plt.style.use("ggplot")

animelist = pd.read_parquet('dataset_files/AnimeList.parquet')
userlist = pd.read_parquet('dataset_files/UserList.parquet')

animelist = animelist.drop(['title_english', 'title_japanese', 'title_synonyms', 'image_url', 'background', 'premiered', 'opening_theme', 'ending_theme'], axis=1)
userlist = userlist.drop(['access_rank', 'join_date', 'last_online'], axis=1)
animelist[['start_date', 'end_date']] = divColumn(animelist, 'aired_string', 'start_date', 'end_date')
toDate(animelist, 'start_date')
toDate(animelist, 'end_date')
toDate(userlist, 'birth_date')
animelist.drop(['aired', 'aired_string'], axis=1)

print(userlist['birth_date'])