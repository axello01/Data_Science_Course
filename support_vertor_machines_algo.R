rm(list = ls())

C:/Users/Graciela/Desktop/BASES FINALES TESIS

	library(quantmod)
	library(e1071)


	start_day <- as.double(100)
	start_date = as.Date(Sys.Date()- start_day)#### Fecha de Inicio
	end_date = (Sys.Date()) ####################### Fecha Final

		symb <- getSymbols("GOOG", src = "yahoo", from = start_date,auto.assign = FALSE,header=FALSE)
		names(symb)[1]='Open'
		names(symb)[2]='High'
		names(symb)[3]='Low'
		names(symb)[4]='Close'
		names(symb)[5]='Volume'
		names(symb)[6]='Adjusted'

		data <- subset(symb,select=c(Volume, Adjusted))

		rsi_2 <- signif(RSI(data$Adjusted,2),2)
		rsi_7 <- signif(RSI(data$Adjusted,7),2)
		rsi_14 <- signif(RSI(data$Adjusted,14),2)
		rsi_21 <- signif(RSI(data$Adjusted,21),2)

		data <- cbind(data,rsi_2,rsi_7,rsi_14,rsi_21)

	
			lag_close_price=lag(data$Adjusted, 1)
data_lag <- cbind(data,lag_close_price)

		names(data_lag)[3]='RSI_2'
		names(data_lag)[4]='RSI_7'
		names(data_lag)[5]='RSI_14'
		names(data_lag)[6]='RSI_21'
		names(data_lag)[7]='Price_Lagged'

		data_diff <- (data_lag$Price_Lagged - data_lag$Adjusted)

		Signal <- 0


	data_lag <- cbind(data_lag,Signal)
		names(data_lag)[8]='Signal'

		                for(i in 2:(nrow(data_lag) - 1)) {
		                        if(data_diff[i] <= 0) {
		                                data_lag$Signal[i] <- 'BAJA'
		                                } else {
		                                data_lag$Signal[i] <- 'SUBE'
		                                }
		                                }


	##################################################
	##### Comienzan parametros SVM ###################
	##################################################

	#svm_train <- as.data.frame(subset((data_lag[23:nrow(data_lag)-1]), select=c(-Adjusted, -Price_Lagged, -Signal)))
	#clase_svm_train <- as.factor(as.vector(subset(data_lag$Signal[23:nrow(data_lag)-1])))


	########### TRAIN #########
	vol_svm_train <- as.vector(as.numeric(subset(data_lag$Volume[23:nrow(data_lag)-1])))
	rsi_2_svm_train <- as.vector(as.numeric(subset(data_lag$RSI_2[23:nrow(data_lag)-1])))
	rsi_7_svm_train <- as.vector(as.numeric(subset(data_lag$RSI_7[23:nrow(data_lag)-1])))
	rsi_14_svm_train <- as.vector(as.numeric(subset(data_lag$RSI_14[23:nrow(data_lag)-1])))
	rsi_21_svm_train <- as.vector(as.numeric(subset(data_lag$RSI_21[23:nrow(data_lag)-1])))

	train_final <- as.data.frame(cbind(vol_svm_train, rsi_2_svm_train, rsi_7_svm_train, rsi_14_svm_train, rsi_21_svm_train))
	clase_train_final <- as.factor(as.vector(subset(data_lag$Signal[23:nrow(data_lag)-1])))


	########### TEST   ################
	vol_svm_test <- as.vector(as.numeric(subset(data_lag$Volume[nrow(data_lag)])))
	rsi_2_svm_test <- as.vector(as.numeric(subset(data_lag$RSI_2[nrow(data_lag)])))
	rsi_7_svm_test <- as.vector(as.numeric(subset(data_lag$RSI_7[nrow(data_lag)])))
	rsi_14_svm_test <- as.vector(as.numeric(subset(data_lag$RSI_14[nrow(data_lag)])))
	rsi_21_svm_test <- as.vector(as.numeric(subset(data_lag$RSI_21[nrow(data_lag)])))

	test_final <- as.data.frame(cbind(vol_svm_test, rsi_2_svm_test, rsi_7_svm_test, rsi_14_svm_test, rsi_21_svm_test))


	############ CREACION DEL MODELO ################

	svm_model <- svm(train_final, clase_train_final)

	############ PREDICCION #########################

	mypredict <- predict(svm_model, test_final)

	print(mypredict)


