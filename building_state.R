towers_destroyed <- function(building_state){
  
bit <- rev(as.integer(intToBits(building_state)))

bs_rad <- bit[c(24:32)]

towers_dire <- 0
for (i in c(1,4,7)) {
  if (bs_rad[i]==0 & bs_rad[i+1]==0 & bs_rad[i+2]==1) {
    line_twr_des <- 0
  } else if (bs_rad[i]==0 & bs_rad[i+1]==1 & bs_rad[i+2]==0) {
    line_twr_des <- 1
  } else if (bs_rad[i]==0 & bs_rad[i+1]==1 & bs_rad[i+2]==1) {
    line_twr_des <- 2
  } else if (bs_rad[i]==1 & bs_rad[i+1]==0 & bs_rad[i+2]==0) {
    line_twr_des <- 3
  }
  towers_dire <- towers_dire + line_twr_des 
}

bs_dire <- bit[c(8:16)]

towers_radiant <- 0
for (i in c(1,4,7)) {
  if (bs_dire[i]==0 & bs_dire[i+1]==0 & bs_dire[i+2]==1) {
    line_twr_des <- 0
  } else if (bs_dire[i]==0 & bs_dire[i+1]==1 & bs_dire[i+2]==0) {
    line_twr_des <- 1
  } else if (bs_dire[i]==0 & bs_dire[i+1]==1 & bs_dire[i+2]==1) {
    line_twr_des <- 2
  } else if (bs_dire[i]==1 & bs_dire[i+1]==0 & bs_dire[i+2]==0) {
    line_twr_des <- 3
  }
  towers_radiant <- towers_radiant + line_twr_des
}
list('towers_radiant' = towers_radiant, 'towers_dire' = towers_dire)
}


