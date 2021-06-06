#scraps
load(file="./data/spell_info.rda")
spells_small <- spell_info %>% select(name, description, "Casting Time", Classes, Duration, Level, School)
spells_small_sep_classes <- 
  spells_small %>% 
  mutate(Classes = gsub(" ","",Classes)) %>% 
  separate(Classes, 
           into = c("classe1","classe2","classe3","classe4","classe5","classe6","classe7"), sep = ",")
carg <- "Warlock"
classe_spells <- spells_small_sep_classes %>% 
  filter(classe1==carg|classe2==carg|classe3==carg|classe3==carg|classe4==carg|classe5==carg|classe6==carg|classe7==carg)


spells_tidy_test <- spells_tidy %>% 
  arrange(Level) %>% 
  mutate(Level = ifelse(Level == 0,"Cantrip", paste0("Spell level : ", Level)))


# V = verbal
# S = sommatic
# M = material

# concentration