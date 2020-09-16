library(tidyverse)
library(rvest)

top_3_IE <- readRDS("C:/Users/fatma/Downloads/top_3_IE.rds")


##Preferred univ analysis

df_uni_boun<-top_3_IE$univ_prefs$BOUN
df_uni_itu<-top_3_IE$univ_prefs$ITU
df_uni_metu<-top_3_IE$univ_prefs$METU
uni_metu_boun<-full_join(df_uni_boun,df_uni_metu)
joined_all_uni<-full_join(uni_metu_boun,df_uni_itu)
joined_all_uni$preference_count<-as.numeric(joined_all_uni$preference_count)
joined_all_uni%>%
  ggplot(.,aes(x=preferred_univ,y=preference_count,color=univ_name))+
  geom_point()+
  labs(x="Preferred Universities", y="Preference Count", color="University Name")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle=90))

#Preferred City analysis

df_city_boun<-top_3_IE$city_prefs$BOUN
df_city_itu<-top_3_IE$city_prefs$ITU
df_city_metu<-top_3_IE$city_prefs$METU
city_metu_boun<-full_join(df_city_boun,df_city_metu)
joined_all_city<-full_join(city_metu_boun,df_city_itu)
joined_all_city$preference_count<-as.numeric(joined_all_city$preference_count)
joined_all_city%>%
  ggplot(.,aes(x=univ_name,y=preference_count,fill=preferred_city))+
  geom_col(position="dodge")+
  labs(x="Universities", y="Preference Count", fill="Preferred Cities")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle=90))


#Preferred Program analysis

df_prog_boun<-top_3_IE$prog_prefs$BOUN
df_prog_boun<-df_prog_boun%>%
  arrange(desc(preference_count))%>%
  head(10)

df_prog_itu<-top_3_IE$prog_prefs$ITU
df_prog_itu<-df_prog_itu%>%
arrange(desc(preference_count))%>%
  head(10)

df_prog_metu<-top_3_IE$prog_prefs$METU
df_prog_metu<-df_prog_metu%>%
arrange(desc(preference_count))%>%
  head(10)

prog_metu_boun<-full_join(df_prog_boun,df_prog_metu)
joined_all_prog<-full_join(prog_metu_boun,df_prog_itu)
joined_all_prog$preference_count<-as.numeric(joined_all_prog$preference_count)
joined_all_prog%>%
  ggplot(.,aes(x=univ_name,y=preference_count,fill=reorder(preferred_program,preference_count)))+
  geom_col(position="dodge")+
  theme(legend.position = "bottom")+
  labs(x="Universities", y="Preference Count", fill="Preferred Programs")
  
