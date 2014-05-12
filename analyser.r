histTwoCollections <- function(data1,data2, col) {
    par(mfrow=c(1,2))
    hist(data1[[col]], main=data1$name[[1]], ylim=c(1,2000), xlim=c(1,20))
    hist(data2[[col]], main=data2$name[[1]], ylim=c(1,2000), xlim=c(1,20))
}

histIntAdv <- function(int,adv,col){
	list_int_male_p1 = list(data_int_male2_p1,data_int_male3_p1,data_int_male4_p1,data_int_male5_p1)
	list_adv_male_p1 = list(data_adv_male1_p1,data_adv_male2_p1,data_adv_male3_p1,data_adv_male4_p1,data_adv_male5_p1)
	all_int_male_p1 = append(data_int_male2_p1[[col]],data_int_male3_p1[[col]])
	all_int_male_p1 = append(all_int_male_p1,data_int_male4_p1[[col]])
	all_int_male_p1 = append(all_int_male_p1,data_int_male5_p1[[col]])

	all_adv_male_p1 = append(data_adv_male1_p1[[col]],data_adv_male2_p1[[col]])
	# all_adv_male_p1 = append(all_adv_male_p1,data_adv_male3_p1[[col]])
	all_adv_male_p1 = append(all_adv_male_p1,data_adv_male4_p1[[col]])
	all_adv_male_p1 = append(all_adv_male_p1,data_adv_male5_p1[[col]])

	print(col)
	print(mean(all_adv_male_p1))
	print(mean(all_int_male_p1))
}

# boxplot(all_adv_male_p1[[col]],all_adv_male_p2[[col]], all_adv_male_p3[[col]], all_int_male_p1[[col]], all_int_male_p2[[col]], all_int_male_p3[[col]])

histIntAdv <- function(int,adv,col){
  col = "y"
  yvalues = c(all_adv_male_p1[[col]],all_adv_male_p2[[col]], all_adv_male_p3[[col]], all_int_male_p1[[col]], all_int_male_p2[[col]], all_int_male_p3[[col]])

  adv_len = length(c(all_adv_male_p1[[col]],all_adv_male_p2[[col]], all_adv_male_p3[[col]]))
  int_len =  length(c(all_int_male_p1[[col]], all_int_male_p2[[col]], all_int_male_p3[[col]]))

  group = rep(1:2, c(adv_len, int_len))

  anova(lm(yvalues~group))

 xbar = tapply(yvalues,group,mean)
 s = tapply(yvalues,group, sd)
 n = tapply(yvalues,group, length)
 sem <- s/sqrt(n)
 stripchart(yvalues~group, method="jitter", jitter=0.05, pch=16, vert=T)
 anova(lm(yvalues~group))
}

#Hypothesis 1

drawBoxL<- function(col,func,main){
#col = "y"
#func = mean

m_l_a_1 = c(func(l_data_adv_male1_p1[[col]]), func(l_data_adv_male2_p1[[col]]), func(l_data_adv_male3_p1[[col]]), func(l_data_adv_male4_p1[[col]]), func(l_data_adv_male5_p1[[col]]))
m_l_i_1 = c(func(l_data_int_male1_p1[[col]]), func(l_data_int_male2_p1[[col]]), func(l_data_int_male3_p1[[col]]), func(l_data_int_male4_p1[[col]]), func(l_data_int_male5_p1[[col]]))
m_a_1 = c(func(data_adv_male1_p1[[col]]), func(data_adv_male2_p1[[col]]), func(data_adv_male3_p1[[col]]), func(data_adv_male4_p1[[col]]), func(data_adv_male5_p1[[col]]))
m_i_1 = c(func(data_int_male1_p1[[col]]), func(data_int_male2_p1[[col]]), func(data_int_male3_p1[[col]]), func(data_int_male4_p1[[col]]), func(data_int_male5_p1[[col]]))
m_l_a_2 = c(func(l_data_adv_male1_p2[[col]]), func(l_data_adv_male2_p2[[col]]), func(l_data_adv_male3_p2[[col]]), func(l_data_adv_male4_p2[[col]]), func(l_data_adv_male5_p2[[col]]))
m_l_i_2 = c(func(l_data_int_male1_p2[[col]]), func(l_data_int_male2_p2[[col]]), func(l_data_int_male3_p2[[col]]), func(l_data_int_male4_p2[[col]]), func(l_data_int_male5_p2[[col]]))
m_a_2 = c(func(data_adv_male1_p2[[col]]), func(data_adv_male2_p2[[col]]), func(data_adv_male3_p2[[col]]), func(data_adv_male4_p2[[col]]), func(data_adv_male5_p2[[col]]))
m_i_2 = c(func(data_int_male2_p2[[col]]), func(data_int_male2_p2[[col]]), func(data_int_male3_p2[[col]]), func(data_int_male4_p2[[col]]), func(data_int_male5_p2[[col]]))
m_l_a_3 = c(func(l_data_adv_male1_p3[[col]]), func(l_data_adv_male2_p3[[col]]), func(l_data_adv_male3_p3[[col]]), func(l_data_adv_male4_p3[[col]]), func(l_data_adv_male5_p3[[col]]))
m_l_i_3 = c(func(l_data_int_male1_p3[[col]]), func(l_data_int_male2_p3[[col]]), func(l_data_int_male3_p3[[col]]), func(l_data_int_male4_p3[[col]]), func(l_data_int_male5_p3[[col]]))
m_a_3 = c(func(data_adv_male1_p3[[col]]), func(data_adv_male2_p3[[col]]), func(data_adv_male3_p3[[col]]), func(data_adv_male4_p3[[col]]), func(data_adv_male5_p3[[col]]))
m_i_3 = c(func(data_int_male1_p3[[col]]), func(data_int_male3_p3[[col]]), func(data_int_male2_p3[[col]]), func(data_int_male4_p3[[col]]), func(data_int_male5_p3[[col]]))

par(mfrow=c(3,2))

las = 1
colors= c("royalblue2","sienna")
names = c("m-adv-s1","m-int-s1")
boxplot(m_l_a_1, m_l_i_1, col=colors,  ylab=col, main=append("Linear Acc ",main), names = names, las = las)
boxplot(m_a_1, m_i_1, col=colors,  ylab=col, main=append("3-Axis Acc ",main), names=names, las = las)

names = c("m-adv-s2",  "m-int-s2")
boxplot(m_l_a_2, m_l_i_2, col=colors,  ylab=col, main=append("Linear Acc ",main), names = names, las = las)
boxplot(m_a_2, m_i_2 , col=colors,  ylab=col, main=append("3-Axis Acc ",main), names=names, las = las)

names= c("m-int-s3", "m-adv-s3")
boxplot(m_l_a_3, m_l_i_3, col=colors,  ylab=col, main=append("Linear Acc ",main), names = names, las = las)
boxplot(m_a_3, m_i_3 , col=colors,  ylab=col, main=append("3-Axis Acc ",main), names=names, las = las)

# t.test(c(m_a_1, m_a_2, m_i_1, m_i_2)~c(1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2), var.equal = T)
# t.test(c(m_a_1, m_i_1)~c(1,1,1,1,1,2,2,2,2,2), var.equal = T)

# hypo2
#print(t.test(c(m_a_1, m_i_1), c(m_a_2, m_i_2), paired=T))
#print(t.test(c(m_a_1, m_i_1), c(m_a_3, m_i_3), paired=T))
#print(t.test(c(m_a_2, m_i_2), c(m_a_3, m_i_3), paired=T))

# hypo1
print(t.test(m_a_1, m_i_1, var.equal=T))
print(t.test(m_a_2, m_i_2, var.equal=T))
print(t.test(m_a_3, m_i_3, var.equal=T))


# fit = lm(c(m_a_1, m_i_1,m_a_2, m_i_2,m_a_3, m_i_3)~c(1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4,5,5,5,5,5,6,6,6,6,6))
# print(anova(fit))
# print(summary(fit))
}

drawBoxLFemale<- function(col,func,main){
#col = "y"
#func = mean

m_l_a_1 = c(func(l_data_adv_female1_p1[[col]]), func(l_data_adv_female2_p1[[col]]), func(l_data_adv_female3_p1[[col]]), func(l_data_adv_female4_p1[[col]]), func(l_data_adv_female5_p1[[col]]))
m_l_i_1 = c(func(l_data_int_female1_p1[[col]]), func(l_data_int_female2_p1[[col]]), func(l_data_int_female3_p1[[col]]), func(l_data_int_female4_p1[[col]]), func(l_data_int_female5_p1[[col]]))
m_a_1 = c(func(data_adv_female1_p1[[col]]), func(data_adv_female2_p1[[col]]), func(data_adv_female3_p1[[col]]), func(data_adv_female4_p1[[col]]), func(data_adv_female5_p1[[col]]))
m_i_1 = c(func(data_int_female1_p1[[col]]), func(data_int_female2_p1[[col]]), func(data_int_female3_p1[[col]]), func(data_int_female4_p1[[col]]), func(data_int_female5_p1[[col]]))
m_l_a_2 = c(func(l_data_adv_female1_p2[[col]]), func(l_data_adv_female2_p2[[col]]), func(l_data_adv_female3_p2[[col]]), func(l_data_adv_female4_p2[[col]]), func(l_data_adv_female5_p2[[col]]))
m_l_i_2 = c(func(l_data_int_female1_p2[[col]]), func(l_data_int_female2_p2[[col]]), func(l_data_int_female3_p2[[col]]), func(l_data_int_female4_p2[[col]]), func(l_data_int_female5_p2[[col]]))
m_a_2 = c(func(data_adv_female1_p2[[col]]), func(data_adv_female2_p2[[col]]), func(data_adv_female3_p2[[col]]), func(data_adv_female4_p2[[col]]), func(data_adv_female5_p2[[col]]))
m_i_2 = c(func(data_int_female2_p2[[col]]), func(data_int_female2_p2[[col]]), func(data_int_female3_p2[[col]]), func(data_int_female4_p2[[col]]), func(data_int_female5_p2[[col]]))
m_l_a_3 = c(func(l_data_adv_female1_p3[[col]]), func(l_data_adv_female2_p3[[col]]), func(l_data_adv_female3_p3[[col]]), func(l_data_adv_female4_p3[[col]]), func(l_data_adv_female5_p3[[col]]))
m_l_i_3 = c(func(l_data_int_female1_p3[[col]]), func(l_data_int_female2_p3[[col]]), func(l_data_int_female3_p3[[col]]), func(l_data_int_female4_p3[[col]]), func(l_data_int_female5_p3[[col]]))
m_a_3 = c(func(data_adv_female1_p3[[col]]), func(data_adv_female2_p3[[col]]), func(data_adv_female3_p3[[col]]), func(data_adv_female4_p3[[col]]), func(data_adv_female5_p3[[col]]))
m_i_3 = c(func(data_int_female1_p3[[col]]), func(data_int_female3_p3[[col]]), func(data_int_female2_p3[[col]]), func(data_int_female4_p3[[col]]), func(data_int_female5_p3[[col]]))

par(mfrow=c(3,2))

las = 1
colors= c("red","palevioletred1")
names = c("f-adv-s1","f-int-s1")
boxplot(m_l_a_1, m_l_i_1, col=colors,  ylab=col, main=append("Linear Acc ",main), names = names, las = las)
boxplot(m_a_1, m_i_1, col=colors,  ylab=col, main=append("3-Axis Acc ",main), names=names, las = las)

names = c("f-adv-s2",  "f-int-s2")
boxplot(m_l_a_2, m_l_i_2, col=colors,  ylab=col, main=append("Linear Acc ",main), names = names, las = las)
boxplot(m_a_2, m_i_2 , col=colors,  ylab=col, main=append("3-Axis Acc ",main), names=names, las = las)

names= c("f-int-s3", "f-adv-s3")
boxplot(m_l_a_3, m_l_i_3, col=colors,  ylab=col, main=append("Linear Acc ",main), names = names, las = las)
boxplot(m_a_3, m_i_3 , col=colors,  ylab=col, main=append("3-Axis Acc ",main), names=names, las = las)

# t.test(c(m_a_1, m_a_2, m_i_1, m_i_2)~c(1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2), var.equal = T)
# t.test(c(m_a_1, m_i_1)~c(1,1,1,1,1,2,2,2,2,2), var.equal = T)

# hypo1
print(t.test(m_a_1, m_i_1, var.equal=T))
print(t.test(m_a_2, m_i_2, var.equal=T))
print(t.test(m_a_3, m_i_3, var.equal=T))


# hypo2
#print(t.test(c(m_a_1, m_i_1), c(m_a_2, m_i_2), paired=T))
#print(t.test(c(m_a_1, m_i_1), c(m_a_3, m_i_3), paired=T))
#print(t.test(c(m_a_2, m_i_2), c(m_a_3, m_i_3), paired=T))

# fit = lm(c(m_a_1, m_i_1)~c(1,1,1,1,1,2,2,2,2,2))
# anova(fit)
}



##############################################
#Hypothesis 2
drawBox<- function(col,func,main){
#col = "y"
#func = mean

m_l_a_1 = c(func(l_data_adv_male1_p1[[col]]), func(l_data_adv_male2_p1[[col]]), func(l_data_adv_male3_p1[[col]]), func(l_data_adv_male4_p1[[col]]), func(l_data_adv_male5_p1[[col]]))
m_l_i_1 = c(func(l_data_int_male1_p1[[col]]), func(l_data_int_male2_p1[[col]]), func(l_data_int_male3_p1[[col]]), func(l_data_int_male4_p1[[col]]), func(l_data_int_male5_p1[[col]]))

m_a_1 = c(func(data_adv_male1_p1[[col]]), func(data_adv_male2_p1[[col]]), func(data_adv_male3_p1[[col]]), func(data_adv_male4_p1[[col]]), func(data_adv_male5_p1[[col]]))
m_i_1 = c(func(data_int_male1_p1[[col]]), func(data_int_male2_p1[[col]]), func(data_int_male3_p1[[col]]), func(data_int_male4_p1[[col]]), func(data_int_male5_p1[[col]]))

m_l_a_2 = c(func(l_data_adv_male1_p2[[col]]), func(l_data_adv_male2_p2[[col]]), func(l_data_adv_male3_p2[[col]]), func(l_data_adv_male4_p2[[col]]), func(l_data_adv_male5_p2[[col]]))
m_l_i_2 = c(func(l_data_int_male1_p2[[col]]), func(l_data_int_male2_p2[[col]]), func(l_data_int_male3_p2[[col]]), func(l_data_int_male4_p2[[col]]), func(l_data_int_male5_p2[[col]]))

m_a_2 = c(func(data_adv_male1_p2[[col]]), func(data_adv_male2_p2[[col]]), func(data_adv_male3_p2[[col]]), func(data_adv_male4_p2[[col]]), func(data_adv_male5_p2[[col]]))
m_i_2 = c(func(data_int_male2_p2[[col]]), func(data_int_male2_p2[[col]]), func(data_int_male3_p2[[col]]), func(data_int_male4_p2[[col]]), func(data_int_male5_p2[[col]]))


m_l_a_3 = c(func(l_data_adv_male1_p3[[col]]), func(l_data_adv_male2_p3[[col]]), func(l_data_adv_male3_p3[[col]]), func(l_data_adv_male4_p3[[col]]), func(l_data_adv_male5_p3[[col]]))
m_l_i_3 = c(func(l_data_int_male1_p3[[col]]), func(l_data_int_male2_p3[[col]]), func(l_data_int_male3_p3[[col]]), func(l_data_int_male4_p3[[col]]), func(l_data_int_male5_p3[[col]]))

m_a_3 = c(func(data_adv_male1_p3[[col]]), func(data_adv_male2_p3[[col]]), func(data_adv_male3_p3[[col]]), func(data_adv_male4_p3[[col]]), func(data_adv_male5_p3[[col]]))
m_i_3 = c(func(data_int_male1_p3[[col]]), func(data_int_male3_p3[[col]]), func(data_int_male2_p3[[col]]), func(data_int_male4_p3[[col]]), func(data_int_male5_p3[[col]]))

#main = append("Func: "," : feature: ",col)
colors= c("royalblue2","royalblue2","royalblue2","sienna","sienna","sienna")

#boxplot(m_l_a_1,m_l_a_2, m_l_a_3 ,m_l_i_1, m_l_i_2, m_l_i_3, m_a_1, m_a_2, m_a_3,  m_i_1 ,  m_i_2,  m_i_3 , col=colors,  ylab=col, main=main)
par(mfrow=c(1,2))
names = c("m-adv-s1", "m-adv-s2", "m-adv-s3", "m-int-s1",  "m-int-s2", "m-int-s3")
boxplot(m_l_a_1,m_l_a_2, m_l_a_3 ,m_l_i_1, m_l_i_2, m_l_i_3, col=colors,  ylab=col, main=append("Linear Acc ",main), names = names, las = 2)
boxplot(m_a_1, m_a_2, m_a_3,  m_i_1 ,  m_i_2,  m_i_3 , col=colors,  ylab=col, main=append("3-Axis Acc ",main), names=names, las = 2)


# t.test(c(m_a_1, m_a_2, m_i_1, m_i_2)~c(1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2), var.equal = T)
# t.test(c(m_a_1, m_i_1)~c(1,1,1,1,1,2,2,2,2,2), var.equal = T)

# hypo2
#print(t.test(c(m_a_1, m_i_1), c(m_a_2, m_i_2), paired=T))
#print(t.test(c(m_a_1, m_i_1), c(m_a_3, m_i_3), paired=T))
#print(t.test(c(m_a_2, m_i_2), c(m_a_3, m_i_3), paired=T))

# fit = lm(c(m_a_1, m_i_1)~c(1,1,1,1,1,2,2,2,2,2))
# anova(fit)
}


drawBoxfemale<- function(col,func,main){
#col = "y"
#func = mean

m_l_a_1 = c(func(l_data_adv_female1_p1[[col]]), func(l_data_adv_female2_p1[[col]]), func(l_data_adv_female3_p1[[col]]), func(l_data_adv_female4_p1[[col]]), func(l_data_adv_female5_p1[[col]]))
m_l_i_1 = c(func(l_data_int_female1_p1[[col]]), func(l_data_int_female2_p1[[col]]), func(l_data_int_female3_p1[[col]]), func(l_data_int_female4_p1[[col]]), func(l_data_int_female5_p1[[col]]))

m_a_1 = c(func(data_adv_female1_p1[[col]]), func(data_adv_female2_p1[[col]]), func(data_adv_female3_p1[[col]]), func(data_adv_female4_p1[[col]]), func(data_adv_female5_p1[[col]]))
m_i_1 = c(func(data_int_female1_p1[[col]]), func(data_int_female2_p1[[col]]), func(data_int_female3_p1[[col]]), func(data_int_female4_p1[[col]]), func(data_int_female5_p1[[col]]))

m_l_a_2 = c(func(l_data_adv_female1_p2[[col]]), func(l_data_adv_female2_p2[[col]]), func(l_data_adv_female3_p2[[col]]), func(l_data_adv_female4_p2[[col]]), func(l_data_adv_female5_p2[[col]]))
m_l_i_2 = c(func(l_data_int_female1_p2[[col]]), func(l_data_int_female2_p2[[col]]), func(l_data_int_female3_p2[[col]]), func(l_data_int_female4_p2[[col]]), func(l_data_int_female5_p2[[col]]))

m_a_2 = c(func(data_adv_female1_p2[[col]]), func(data_adv_female2_p2[[col]]), func(data_adv_female3_p2[[col]]), func(data_adv_female4_p2[[col]]), func(data_adv_female5_p2[[col]]))
m_i_2 = c(func(data_int_female2_p2[[col]]), func(data_int_female2_p2[[col]]), func(data_int_female3_p2[[col]]), func(data_int_female4_p2[[col]]), func(data_int_female5_p2[[col]]))

m_l_a_3 = c(func(l_data_adv_female1_p3[[col]]), func(l_data_adv_female2_p3[[col]]), func(l_data_adv_female3_p3[[col]]), func(l_data_adv_female4_p3[[col]]), func(l_data_adv_female5_p3[[col]]))
m_l_i_3 = c(func(l_data_int_female1_p3[[col]]), func(l_data_int_female2_p3[[col]]), func(l_data_int_female3_p3[[col]]), func(l_data_int_female4_p3[[col]]), func(l_data_int_female5_p3[[col]]))

m_a_3 = c(func(data_adv_female1_p3[[col]]), func(data_adv_female2_p3[[col]]), func(data_adv_female3_p3[[col]]), func(data_adv_female4_p3[[col]]), func(data_adv_female5_p3[[col]]))
m_i_3 = c(func(data_int_female1_p3[[col]]), func(data_int_female3_p3[[col]]), func(data_int_female2_p3[[col]]), func(data_int_female4_p3[[col]]), func(data_int_female5_p3[[col]]))

colors = c("red" ,"red" ,"red","palevioletred1" ,"palevioletred1" ,"palevioletred1")

par(mfrow=c(1,2))
names = c("f-adv-s1", "f-adv-s2", "f-adv-s3", "f-int-s1",  "f-int-s2", "f-int-s3")
boxplot(m_l_a_1,m_l_a_2, m_l_a_3 ,m_l_i_1, m_l_i_2, m_l_i_3, col=colors,  ylab=col, main=append("Female Linear Acc ",main), names = names, las = 2)
boxplot(m_a_1, m_a_2, m_a_3,  m_i_1 ,  m_i_2,  m_i_3 , col=colors,  ylab=col, main=append("Female 3-Axis Acc ",main), names=names, las = 2)

# t.test(c(m_a_1, m_a_2, m_i_1, m_i_2)~c(1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2), var.equal = T)
# t.test(c(m_a_1, m_i_1)~c(1,1,1,1,1,2,2,2,2,2), var.equal = T)

# hypo2
#print(t.test(c(m_a_1, m_i_1), c(m_a_2, m_i_2), paired=T))
#print(t.test(c(m_a_1, m_i_1), c(m_a_3, m_i_3), paired=T))
#print(t.test(c(m_a_2, m_i_2), c(m_a_3, m_i_3), paired=T))

# fit = lm(c(m_a_1, m_i_1)~c(1,1,1,1,1,2,2,2,2,2))
# anova(fit)
}


drawBoxQ<- function(func){

d_m_i_1 = read.table("~/Downloads/data/int-male-p1.d")
d_m_i_2 = read.table("~/Downloads/data/int-male-p2.d")
d_m_i_3 = read.table("~/Downloads/data/int-male-p3.d")

d_f_i_1 = read.table("~/Downloads/data/int-female-p1.d")
d_f_i_2 = read.table("~/Downloads/data/int-female-p2.d")
d_f_i_3 = read.table("~/Downloads/data/int-female-p3.d")

d_m_a_1 = read.table("~/Downloads/data/adv-male-p1.d")
d_m_a_2 = read.table("~/Downloads/data/adv-male-p2.d")
d_m_a_3 = read.table("~/Downloads/data/adv-male-p3.d")

d_f_a_1 = read.table("~/Downloads/data/adv-female-p1.d")
d_f_a_2 = read.table("~/Downloads/data/adv-female-p2.d")
d_f_a_3 = read.table("~/Downloads/data/adv-female-p3.d")

# hypo2
print(t.test(c(func(d_m_a_1$V1), func(d_m_i_1$V1)), c(func(d_m_a_2$V1), func(d_m_i_2$V1)), paired=T))
print(t.test(c(func(d_m_a_1$V1), func(d_m_i_1$V1)), c(func(d_m_a_3$V1), func(d_m_i_3$V1)), paired=T))
print(t.test(c(func(d_m_a_2$V1), func(d_m_i_2$V1)), c(func(d_m_a_3$V1), func(d_m_i_3$V1)), paired=T))

print(t.test(c(func(d_f_a_1$V1), func(d_f_i_1$V1)), c(func(d_f_a_2$V1), func(d_f_i_2$V1)), paired=T))
print(t.test(c(func(d_f_a_1$V1), func(d_f_i_1$V1)), c(func(d_f_a_3$V1), func(d_f_i_3$V1)), paired=T))
print(t.test(c(func(d_f_a_2$V1), func(d_f_i_2$V1)), c(func(d_f_a_3$V1), func(d_f_i_3$V1)), paired=T))

# hypo 2
colors= c("royalblue2","sienna")
par(mfrow=c(1,3))
boxplot(c(func(d_m_a_1$V1), func(d_m_i_1$V1)), c(func(d_m_a_2$V1), func(d_m_i_2$V1)), col=colors, names = c("m-s1","m-s2"), ylab="mean", main="Male mean")
boxplot(c(func(d_m_a_1$V1), func(d_m_i_1$V1)), c(func(d_m_a_3$V1), func(d_m_i_3$V1)), col=colors, names = c("m-s1","m-s3"), ylab="mean", main="Male mean")
boxplot(c(func(d_m_a_2$V1), func(d_m_i_2$V1)), c(func(d_m_a_3$V1), func(d_m_i_3$V1)), col=colors, names = c("m-s2","m-s3"), ylab="mean", main="Male mean")

colors= c("red","palevioletred1")
#par(mfrow=c(1,3))
#boxplot(c(func(d_f_a_1$V1), func(d_f_i_1$V1)), c(func(d_f_a_2$V1), func(d_f_i_2$V1)), col=colors, names = c("f-s1","f-s2"))
#boxplot(c(func(d_f_a_1$V1), func(d_f_i_1$V1)), c(func(d_f_a_3$V1), func(d_f_i_3$V1)), col=colors, names = c("f-s1","f-s3"))
#boxplot(c(func(d_f_a_2$V1), func(d_f_i_2$V1)), c(func(d_f_a_3$V1), func(d_f_i_3$V1)), col=colors, names = c("f-s2","f-s3"))

# hypo 1
par(mfrow=c(1,3))
boxplot(d_f_a_1$V1, d_f_i_1$V1, col=colors, names = c("f-a-s1","f-i-s1"), ylab="Q value", main="Female Q value")
boxplot(d_f_a_2$V1, d_f_i_2$V1, col=colors, names = c("f-a-s2","f-i-s2"), ylab="Q value", main="Female Q value")
boxplot(d_f_a_3$V1, d_f_i_3$V1, col=colors, names = c("f-a-s3","f-i-s3"), ylab="Q value", main="Female Q value")

#par(mfrow=c(1,3))
#boxplot(d_m_a_1$V1, d_m_i_1$V1)
#boxplot(d_m_a_2$V1, d_m_i_2$V1)
#boxplot(d_m_a_3$V1, d_m_i_3$V1)

# hypo1
print(t.test(d_f_a_1$V1, d_f_i_1$V1, var.equal=T))
print(t.test(d_f_a_2$V1, d_f_i_2$V1, var.equal=T))
print(t.test(d_f_a_3$V1, d_f_i_3$V1, var.equal=T))


print(t.test(d_m_a_1$V1, d_m_i_1$V1, var.equal=T))
print(t.test(d_m_a_2$V1, d_m_i_2$V1, var.equal=T))
print(t.test(d_m_a_3$V1, d_m_i_3$V1, var.equal=T))
}


drawBoxC<- function(){
#hypo1
main="Bounce count data males"
names= c("m-a-s1","m-a-s2","m-a-s3","m-i-s1","m-i-s2","m-i-s3")
colors= c("royalblue2","royalblue2","royalblue2","sienna","sienna","sienna")
#boxplot(male$V1[0:5],male$V1[11:15],male$V1[6:10], male$V2[0:5],male$V2[11:15],male$V2[6:10], names=names, ylab="Bounce count values", col=colors, main=main)

par(mfrow=c(1,2))
#hypo2
colors= c("yellow","skyblue2", "darkred")
names= c("m-s1","m-s2","m-s3")
boxplot(c(male$V1[0:5],male$V2[0:5]), c(male$V1[11:15],male$V2[11:15]), c(male$V1[6:10],male$V2[6:10]), names=names, ylab="Bounce count values", col=colors, main=main)

main="Bounce count data females"
colors= c("yellow","skyblue2", "darkred")
names= c("m-s1","m-s2","m-s3")
boxplot(c(female$V1[0:5],female$V2[0:5]), c(female$V1[11:15],female$V2[11:15]), c(female$V1[6:10],female$V2[6:10]), names=names, ylab="Bounce count values", col=colors, main=main)

}

drawBoxCFemale<- function(){
#hypo1
main="Bounce count data females"
colors = c("red" ,"red" ,"red","palevioletred1" ,"palevioletred1" ,"palevioletred1")
names= c("f-a-s1","f-a-s2","f-a-s3","f-i-s1","f-i-s2","f-i-s3")
#boxplot(female$V1[0:5], female$V1[11:15],female$V1[6:10], female$V2[0:5],female$V2[11:15], female$V2[6:10], names=names, ylab="Bounce count values", col=colors, main=main)
#hypo2
colors= c("yellow","skyblue2", "darkred")
names= c("m-s1","m-s2","m-s3")
boxplot(c(female$V1[0:5],female$V2[0:5]), c(female$V1[11:15],female$V2[11:15]), c(female$V1[6:10],female$V2[6:10]), names=names, ylab="Bounce count values", col=colors, main=main)

}