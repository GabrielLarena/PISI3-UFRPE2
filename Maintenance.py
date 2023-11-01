import pandas as pd
import numpy as np

def divColumn (dataf, column, nc1, nc2):
    "divida column em duas colunas nc1 e nc2"
    dataf[[nc1, nc2]] = dataf[column].str.split(' to ', n=1, expand=True)


def toDate(dataf, column):
    "Substitui os valores Not Available por valores nulos e converte a coluna em data."
    dataf[column].replace('Not available', np.nan, inplace=True)
    dataf[column] = pd.to_datetime(dataf[column], format='%b %d, %Y', errors='coerce')


def changePlace(dataf, c1, c2):
    "Troca duas colunas de lugar"
    dataf[c1], dataf[c2] = dataf[c2], dataf[c1]
    dataf.rename(columns={c1: c2, c2: c1}, inplace=True)


def main():
    df = pd.read_csv('dataset_files/AnimeList.csv')
    divColumn(df, 'aired_string', 'start_date', 'end_date')
    toDate(df, 'start_date')
    toDate(df, 'end_date')
    changePlace(df, 'start_date', 'duration')   
    changePlace(df, 'end_date', 'rating')
    df.to_csv('dataset_files/AnimeList.csv')


main()