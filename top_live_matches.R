library(RDota2)
library(plyr)
library(magrittr)
library(tidyr)

api_key = 'C8A277A7606C4AEA3E6C9F54AA63BDED'
key_actions(action = 'register_key', value = api_key)

matches_info <- function(){

M_info <- list()
for (i in 0:3) {
  M_info[[i + 1]] <- ldply(get_top_live_game(partner = i)$content$game_list, data.frame)
  m_all_info <- ldply(M_info, data.frame)
}

match_list <- m_all_info %>% 
  drop_na(team_name_radiant) %>%
  drop_na(team_name_dire) %>%
  subset(
    select = c(
      activate_time,
      server_steam_id,
      team_name_radiant,
      team_name_dire,
      game_time,
      delay,
      spectators,
      radiant_lead,
      radiant_score,
      dire_score,
      building_state
    )
  )

print(match_list)

}

top_live_matches <- function(team_name) {
  
  M <- list()
  for (i in 0:3) {
    M[[i + 1]] <- ldply(get_top_live_game(partner = i)$content$game_list, data.frame)
    m_all <- ldply(M, data.frame)
  }
  
  matches <- m_all %>% 
    drop_na(team_name_radiant) %>% 
    drop_na(team_name_dire) %>% 
    subset(
      select = c(
        activate_time,
        server_steam_id,
        team_name_radiant,
        team_name_dire,
        game_time,
        delay,
        spectators,
        radiant_lead,
        radiant_score,
        dire_score,
        building_state
      )
    )
  
  # print(matches)
  # team_name <- 'the wings gaming'
  
  t_rad <- m_all[m_all$team_name_radiant == team_name, ][1, ]
  t_dire <- m_all[m_all$team_name_dire == team_name, ][1, ]
  
  if (!is.na(t_rad$team_name_radiant == team_name)) {
    building_state <- t_rad$building_state
  } else if (!is.na(t_dire$team_name_dire == team_name)) {
    building_state <- t_rad$building_state
  }
    


  # building_state <- t_rad$building_state
  # building_state <- 4784201

towers_destroyed <- function(building_state){

  # convert
  bit <- rev(as.integer(intToBits(building_state)))

  # split to light/dark
  fac <- rep(1:3, each = 3)
  nms <- c('bottom','mid','top')
  bit_light <- bit[c(24:32)] %>% split(fac) %>% set_names(nms)
  bit_dark <- bit[c(8:16)] %>% split(fac) %>% set_names(nms)

  # count destroyed
  bit_to_destroyed <- function(bit){
    towers <- bit[1] * 2^2 + bit[2] * 2^1 + bit[3] * 2^0 - 1
    min(towers, 3)
  }

  list(
    towers_light = lapply(bit_light, bit_to_destroyed) %>% unlist %>% sum,
    towers_dark = lapply(bit_dark, bit_to_destroyed) %>% unlist %>% sum
  )

  
  
}



if (!is.na(t_rad$team_name_radiant == team_name)) {
  t_rad %>% 
    drop_na(team_name_radiant) %>% 
    drop_na(team_name_dire) %>% 
    subset(
      select = c(
        activate_time,
        server_steam_id,
        team_name_radiant,
        team_name_dire,
        game_time,
        delay,
        spectators,
        radiant_lead,
        radiant_score,
        dire_score,
        building_state
      ))
} else if (!is.na(t_dire$team_name_dire == team_name)) {
  t_dire
} else
  print("hovno")

}

while(T){
  matches_info()
  Sys.sleep(20)
}

while(T){
  print(top_live_matches('Execration'))
  Sys.sleep(5)
}