# iSignDB_2020
It's a database created to design foolproof biometric signature authentication system for smartphone users.

-The dataset iSignDB is created to implement a novel anti-spoof biometric signature authentication for smartphone users.

-We named it iSignDB as we collected it using licensed MathWorks cloud account with two devices iPhone 7 Plus and Redmi Note 7 for capturing dynamic signatures.

-A total of 48 subjects volunteered for data collection out of which we identified 32 users as genuine signature contributors and 16 users as fake signature contributors with skilled forgery.

-Data was collected in 3 different sessions separated by at least 20 days in order to capture the emotional intelligence of users.

-During each session, one pair of subjects, out of which one subject contributed 10 original signatures and the other contributed 5 fake signatures.

-For obtaining a fake signature, a subject was allowed to practice not only the signature image of a genuine user but also the behaviorism (e.g. number of touchpoints, style of finger movement while signing, etc.) with genuine signer signs on the touch screen of a smartphone.

-A total of 30 genuine and 15 fake samples were collected for every 32 users.

-One sign of a user contains a sensor log of these devices captured using sensors present in device iPhone 7 Plus: Accelerometer, Gyroscope, Magnetometer, and GPS, etc along with images of signature as obtained by performing a sign on the touch screen of the device.

-Currently, we only put biometric sign database of user 1 only in this repository, but as soon as this work is published, we will make the full database of 32 users available here with some terms and conditions.

-We successfully trained 32 LSTM models on dynamic signature dataset created with EER of 3.35% which is a significant improvement overall such models in existing literature (HMOG, and eBioSignDS 2).

-We provide Matlab code (compatible with MATLAB 2020a licensed version) for training, testing, and calculating EER in this repository.

-Nomenclature for files in the dataset iSignDB: (each sign with 4 sensor logs corresponding to Acceleration, Angular Velocity, Magnetic Field, and Position, and image of signature
u01_s3_r010_AngVel.txt : means a signature of user 1, on session 3, real signature, 10th sample’s Angular velocity sensor log
u01_s1_f02_MagField.txt : means a signature of user 1, on session 1, fake signature, 2nd sample’s magnetic field sensor log
u01_s1_r01_im.png : image of the genuine signature of user 1, captured on session 1, sample 1

iSignDB will be made available to other researchers only after signing its "Term of use" agreement.
