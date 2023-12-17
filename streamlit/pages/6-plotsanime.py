import pandas as pd
import numpy as np
import streamlit as st
import plotly.express as px
import plotly.graph_objects as go

df_anime = pd.read_parquet("data/preprocessamento/AnimeList.parquet")
df_user = pd.read_parquet("data/preprocessamento/UserList.parquet")
df_userscore = pd.read_parquet("data/preprocessamento/UserAnimeList2.parquet")