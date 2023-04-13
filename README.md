# Crop Care

Crop Care is a Flutter application that uses a deep learning model to classify plant diseases based on images of plant leaves. The application currently supports four plant types: Potato, Corn, Cotton, and Grapes. The app allows users to take a photo of a plant leaf or select an image from their mobile device's file system, and then the app uses the deep learning model to classify the image as healthy or diseased, and also identifies the type of plant.

## Installation

To use Crop Care, follow these steps:

1. Clone this repository to your local machine.
2. Install the Flutter SDK.
3. Connect your device or emulator.
4. Run the following command to install the required packages:
   `flutter pub get`
5. Run the app with the following command:
   `flutter run`

## Usage

To use Crop Care, follow these instructions:

1. Open the app.
2. On the home screen, select either the "Select Photo from Gallery" button or the "Select Image from Camera" button to choose an image of a plant leaf.
3. The image is then passed to the deep learning model, which classifies the image as healthy or diseased and identifies the type of plant.
4. The processed image is stored in the local storage.
5. To view the processed images, navigate to the "Processed Images" page which is on the left side of the home screen.
6. The processed images are displayed as a list of cards, which show the original image, the classification result, and the identified plant type.

## Credits

Crop Care was created by Pranav. The deep learning model used by the app was trained using the [plant-disease-classifier.ipynb](https://github.com/jeevanpranav02/Crop-Care/blob/main/plant-disease-classifier.ipynb) Jupyter Notebook. If you have any questions or feedback, please contact me at [pranavjothimani2002@gmail.com].
