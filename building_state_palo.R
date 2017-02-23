require(magrittr)

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



