# macos_firestore
An example app that shows Firestore working on macOS.

The only thing it is missing is a GoogleService-Info.plist file. Open macos_firebase/macos/Runner.xcworkspace with XCode. Download the plist file from the Firestore project you created. I dragged my plist file into the top level 'Runner', although I think I've seen other places put it elsewhere. I don't know the differences really between the different places. 

Once you add the plist file and run the app, it should pull all documents from the mycollection collection in your Firestore project. (So make sure that collection exists and has documents, or change the name in the code). 