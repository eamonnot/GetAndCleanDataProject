This Codebook describes the variables generated during the data tidy process implemented in run_analysis.R.

## Raw Data
The raw data is the UCI HAR Dataset, available from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The raw data contains date from a human activity recognition experiment carried out using smart phones with 30 volunteers. Volunteers carried out 6 physical activities while carrying the smart phone and the embedded accelerometer and gyroscope sensors on the phone were used to monitor user movement in 3 axis, x, y and z. The raw data is split across training and test datasets with each dataset containing information on sensor readings, the activity and the subject who carried out it out. The original sensor data was pre-processed using sliding window sampling and noise filtering, with the minimum, maximum, mean, standard deviation etc., calculated for each of these windows during activity. Finally, the raw data is normalised and bounded within [-1,1].

## Codebook
### Processing
The raw data was transformed to merge the train and test datasets into a single data set. This merging included merging the sensor data, the activity data and the subject data into a single tidy dataset. Additionally, the dataset was processed to remove all sensor data that does not relate to mean or standard deviation data. The data is grouped by activity and subject with the average calculated for all variables based on this grouping. Activity codes in the raw data are replaced with descriptive activity names. Finally, the variable names have been transformed to ensure they are human readable in accordance with tidy data practices.

### Units of data
The raw data contained in the UCI HAR Dataset was processed to normalise the data and bound all variables between [-1,1]. As a result of this processing the raw data is unit free and therefore the processed tidy data described below is also unit free. The data contained in the tidy data is a averaging of this normalised data.

### Variable Descriptions

1. Activity
* The name of the activity completed during the experiment.
2. SubjectID
* The ID of the subject who carried out the acitivty
3. TimeBodyAccelerometerXAxisMean                                
* Mean of the body acceleration on the x-axis in the time domain                            
4. TimeBodyAccelerometerYAxisMean                                
* Mean of the body acceleration on the y-axis in the time domain                            
5. TimeBodyAccelerometerZAxisMean                                
* Mean of the body acceleration on the z-axis in the time domain                            
6. TimeBodyAccelerometerXAxisStandardDeviation                   
* Standard Deviation of the body acceleration on the x-axis in the time domain              
7. TimeBodyAccelerometerYAxisStandardDeviation                   
* Standard Deviation of the body acceleration on the y-axis in the time domain              
8. TimeBodyAccelerometerZAxisStandardDeviation                   
* Standard Deviation of the body acceleration on the z-axis in the time domain              
9. TimeGravityAccelerometerXAxisMean                             
* Mean of the gravity acceleration on the x-axis in the time domain                         
10.TimeGravityAccelerometerYAxisMean                             
* Mean of the gravity acceleration on the y-axis in the time domain                         
11.TimeGravityAccelerometerZAxisMean                             
* Mean of the gravity acceleration on the z-axis in the time domain                         
12.TimeGravityAccelerometerXAxisStandardDeviation                
* Standard deviation of the gravity acceleration on the x-axis in the time domain                       
13.TimeGravityAccelerometerYAxisStandardDeviation                
* Standard deviation of the gravity acceleration on the y-axis in the time domain           
14.TimeGravityAccelerometerZAxisStandardDeviation                
* Standard deviation of the gravity acceleration on the z-axis in the time domain           
15.TimeBodyAccelerometerJerkXAxisMean                            
* Mean of the body jerk acceleration on the x-axis in the time domain                       
16.TimeBodyAccelerometerJerkYAxisMean                            
* Mean of the body jerk acceleration on the y-axis in the time domain                       
17.TimeBodyAccelerometerJerkZAxisMean                            
* Mean of the body jerk acceleration on the z-axis in the time domain                       
18.TimeBodyAccelerometerJerkXAxisStandardDeviation               
* Standard deviation of the body jerk acceleration on the x-axis in the time domain         
19.TimeBodyAccelerometerJerkYAxisStandardDeviation               
* Standard deviation of the body jerk acceleration on the y-axis in the time domain         
20.TimeBodyAccelerometerJerkZAxisStandardDeviation               
* Standard deviation of the body jerk acceleration on the z-axis in the time domain         
21.TimeBodyGyroscopeXAxisMean                                    
* Mean of the body angular velocity on the x-axis in the time domain                        
22.TimeBodyGyroscopeYAxisMean                                    
* Mean of the body angular velocity on the y-axis in the time domain                        
23.TimeBodyGyroscopeZAxisMean                                    
* Mean of the body angular velocity on the z-axis in the time domain                        
24.TimeBodyGyroscopeXAxisStandardDeviation                       
* Standard deviaiton of the body angular velocity on the x-axis in the time domain          
25.TimeBodyGyroscopeYAxisStandardDeviation                       
* Standard deviaiton of the body angular velocity on the y-axis in the time domain          
26.TimeBodyGyroscopeZAxisStandardDeviation                       
* Standard deviaiton of the body angular velocity on the z-axis in the time domain          
27.TimeBodyGyroscopeJerkXAxisMean                                
* Mean of the body jerk angular velocity on the x-axis in the time domain                   
28.TimeBodyGyroscopeJerkYAxisMean                                
* Mean of the body jerk angular velocity on the y-axis in the time domain                   
29.TimeBodyGyroscopeJerkZAxisMean                                
* Mean of the body jerk angular velocity on the z-axis in the time domain                   
30.TimeBodyGyroscopeJerkXAxisStandardDeviation                   
* Standard deviation of the body jerk angular velocity on the x-axis in the time domain     
31.TimeBodyGyroscopeJerkYAxisStandardDeviation                   
* Standard deviation of the body jerk angular velocity on the y-axis in the time domain     
32.TimeBodyGyroscopeJerkZAxisStandardDeviation                   
* Standard deviation of the body jerk angular velocity on the z-axis in the time domain     
33.TimeBodyAccelerometerMagnitudeMean                            
* Mean of the magnitude of body acceleration in the time domain                             
34.TimeBodyAccelerometerMagnitudeStandardDeviation               
* Standard deviation of the magnitude of body acceleration in the time domain               
35.TimeGravityAccelerometerMagnitudeMean                         
* Mean of the magnitude of gravity acceleration in the time domain                          
36.TimeGravityAccelerometerMagnitudeStandardDeviation            
* Standard deviation of the magnitude of body acceleration in the time domain               
37.TimeBodyAccelerometerJerkMagnitudeMean                        
* Mean of the magnitude of body jerk acceleration in the time domain                        
38.TimeBodyAccelerometerJerkMagnitudeStandardDeviation           
* Standard deviation of the magnitude of body jerk acceleration in the time domain          
39.TimeBodyGyroscopeMagnitudeMean                                
* Mean of the magnitude of body angular velocity in the time domain                         
40.TimeBodyGyroscopeMagnitudeStandardDeviation                   
* Standard deviation of the magnitude of body angular velocity in the time domain                  
41.TimeBodyGyroscopeJerkMagnitudeMean                            
* Mean of the magnitude of body jerk angular velocity in the time domain                           
42.TimeBodyGyroscopeJerkMagnitudeStandardDeviation               
* Standard deviation of the magnitude of body jerk angular velocity in the time domain             
43.FrequencyBodyAccelerometerXAxisMean                           
* Mean of the body acceleration on the x-axis in the frequency domain                              
44.FrequencyBodyAccelerometerYAxisMean                           
* Mean of the body acceleration on the y-axis in the frequency domain                              
45.FrequencyBodyAccelerometerZAxisMean                           
* Mean of the body acceleration on the z-axis in the frequency domain                              
46.FrequencyBodyAccelerometerXAxisStandardDeviation              
* Standard deviation of the body acceleration on the x-axis in the frequency domain                
47.FrequencyBodyAccelerometerYAxisStandardDeviation              
* Standard deviation of the body acceleration on the y-axis in the frequency domain                 
48.FrequencyBodyAccelerometerZAxisStandardDeviation              
* Standard deviation of the body acceleration on the z-axis in the frequency domain                
49.FrequencyBodyAccelerometerJerkXAxisMean                       
* Mean of the body jerk acceleration on the x-axis in the frequency domain                         
50.FrequencyBodyAccelerometerJerkYAxisMean                       
* Mean of the body jerk acceleration on the y-axis in the frequency domain                        
51.FrequencyBodyAccelerometerJerkZAxisMean                       
* Mean of the body jerk acceleration on the z-axis in the frequency domain                        
52.FrequencyBodyAccelerometerJerkXAxisStandardDeviation          
* Standard deviation of the body jerk acceleration on the x-axis in the frequency domain           
53.FrequencyBodyAccelerometerJerkYAxisStandardDeviation          
* Standard deviation of the body jerk acceleration on the y-axis in the frequency domain           
54.FrequencyBodyAccelerometerJerkZAxisStandardDeviation          
* Standard deviation of the body jerk acceleration on the z-axis in the frequency domain           
55.FrequencyBodyGyroscopeXAxisMean                               
* Mean of the body angular velocity on the x-axis in the frequency domain                          
56.FrequencyBodyGyroscopeYAxisMean                               
* Mean of the body angular velocity on the y-axis in the frequency domain                          
57.FrequencyBodyGyroscopeZAxisMean                               
* Mean of the body angular velocity on the z-axis in the frequency domain                          
58.FrequencyBodyGyroscopeXAxisStandardDeviation                  
* Standard deviation of the body angular velocity on the x-axis in the frequency domain            
59.FrequencyBodyGyroscopeYAxisStandardDeviation                  
* Standard deviation of the body angular velocity on the y-axis in the frequency domain           
60.FrequencyBodyGyroscopeZAxisStandardDeviation                  
* Standard deviation of the body angular velocity on the z-axis in the frequency domain     
61.FrequencyBodyAccelerometerMagnitudeMean                       
* Mean of the magnitude of body acceleraiton in the frequency domain                        
62.FrequencyBodyAccelerometerMagnitudeStandardDeviation          
* Standard deviation of the magnitude of body acceleraiton in the frequency domain          
63.FrequencyBodyBodyAccelerometerJerkMagnitudeMean               
* Mean of the magnitude of body jerk acceleraiton in the frequency domain                   
64.FrequencyBodyBodyAccelerometerJerkMagnitudeStandardDeviation  
* Standard deviation of the magnitude of body jerk acceleraiton in the frequency domain     
65.FrequencyBodyBodyGyroscopeMagnitudeMean                       
* Mean of the magnitude of body angular velocity in the frequency domain                    
66.FrequencyBodyBodyGyroscopeMagnitudeStandardDeviation          
* Standard deviation of the magnitude of body angular velocity in the frequency domain      
67.FrequencyBodyBodyGyroscopeJerkMagnitudeMean                   
* Mean of the magnitude of body jerk angular velocity in the frequency domain               
68.FrequencyBodyBodyGyroscopeJerkMagnitudeStandardDeviation      
* Standard deviation of the magnitude of body jerk angular velocity in the frequency domain     


