import dota2api
import pandas as pd
import datetime
import time

api_key = '31E3FBF10CF43BAB0689093F80FF7535'
api = dota2api.Initialise(api_key=api_key)


def check(team):
  game_time = 0
global rad_lead
rad_lead = pd.DataFrame()
while True: 
  df = api.get_top_live_games()
df = df['game_list']
df = pd.DataFrame(df)
df = df[df['team_name_radiant']==team]
pozice = list(df.index)
pozice = pozice[0]
while True:
  game_timeold = game_time
game_time = df.loc[pozice,"game_time"]
if game_time > game_timeold:
  radiant_lead = df.loc[pozice,'radiant_lead']
radiant_score = df.loc[pozice,'radiant_score']
dire_score = df.loc[pozice,'dire_score']
b_st = bin(df.loc[pozice,'building_state'])
df_ap = {'game_time' : game_time,'radiant_lead' : radiant_lead}
rad_lead = rad_lead.append(df_ap,ignore_index=True)
print('game_time:    '+str(datetime.timedelta(seconds=int(game_time))))
print('radiant_lead: '+str(radiant_lead))
print('radiant_score:'+str(radiant_score))
print('dire_score:   '+str(dire_score))
print('radiant:'+b_st[15:18]+' '+b_st[18:21]+''+b_st[21:24])
print('dire:'+b_st[2:5]+' '+b_st[5:8]+''+b_st[8:11])        
print("#################################")
else:
  time.sleep(5)
break
def teams():
  global t
df = api.get_top_live_games(partner=3)
df = df['game_list']
df = pd.DataFrame(df)
df = df[df['team_name_dire'].notnull()]
t = df['team_name_radiant'].tolist()
return df[['team_name_radiant','team_name_dire','delay']]