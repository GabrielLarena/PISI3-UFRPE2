import pandas as pd
import numpy as np
import matplotlib.pylab as plt
import seaborn as sns
import datetime
import plotly.express as px


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


def toMinutes(column):
    hours = min = 0
    part = column.split()
    if 'hr.' in part:
        hours = int(part[0])
        if 'min.' in part:
            min = int(part[2])
        return (hours * 60) + min
    elif 'min.' in column:
        return int(part[0])
    return hours + min 


def main():


main()