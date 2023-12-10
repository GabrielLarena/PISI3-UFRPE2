import streamlit as st
import pandas as pd
import io

df = pd.read_parquet("data/AnimeList.parquet")

animelist = df[df.genre.notnull()][['anime_id','title','type','source','episodes','airing','duration','rating','score','scored_by','rank','popularity', 'favorites' ,'members', 'producer', 'licensor','studio','genre']].copy()

animelist[["start", "end"]] = df['aired_string'].str.split(' to ', n=1, expand=True)

animelist["start"] = pd.to_datetime(animelist["start"], format='%b %d, %Y', errors='coerce')
animelist["end"] = pd.to_datetime(animelist["end"], format='%b %d, %Y', errors='coerce')

def toMinutes(column):
    hours = 0
    minutes = 0
    part = column.split()
    if 'hr.' in part:
        hours = int(part[0])
        if 'min.' in part:
            minutes = int(part[2])
        return (hours * 60) + minutes
    elif 'min.' in column:
        return int(part[0])
    return hours + minutes

animelist["duration"] = animelist["duration"].apply(toMinutes)

animelist["genre"] = animelist.genre.str.split(", ").copy()

st.write(animelist.head())


st.write("Função info")
buffer = io.StringIO()
animelist.info(buf=buffer)
s = buffer.getvalue()

with st.expander("Info"):
    st.text(s)