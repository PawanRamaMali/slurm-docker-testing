
# CNN MNIST Classifier

This document provides a comprehensive explanation of a Convolutional Neural Network (CNN) implementation for classifying handwritten digits using the MNIST dataset.

## 1. Introduction

The MNIST dataset is a benchmark dataset consisting of 28x28 grayscale images of handwritten digits (0-9). The task is to classify these digits using a CNN model built with TensorFlow and Keras.

## 2. Code Explanation

### Importing Libraries

```python
import tensorflow as tf
from tensorflow.keras import layers, models
from tensorflow.keras.datasets import mnist
from tensorflow.keras.utils import to_categorical
```

- **tensorflow**: Provides the core functionality for building and training the model.
- **layers**: Contains the building blocks of the CNN, such as `Conv2D` and `Dense`.
- **models**: Used for creating a sequential model.
- **mnist**: Utility for loading the MNIST dataset.
- **to_categorical**: Converts class vectors to binary class matrices (one-hot encoding).

### Loading and Preprocessing the Dataset

```python
(train_images, train_labels), (test_images, test_labels) = mnist.load_data()
```

- **mnist.load_data()**: Loads the MNIST dataset, split into training (60,000 images) and testing (10,000 images) sets.

```python
train_images = train_images.reshape((60000, 28, 28, 1)).astype('float32') / 255
test_images = test_images.reshape((10000, 28, 28, 1)).astype('float32') / 255
```

- **reshape**: Reshapes the data to include a single channel for grayscale images.
- **astype('float32')**: Converts the data type to `float32`.
- **/ 255**: Normalizes pixel values to the range [0, 1].

```python
train_labels = to_categorical(train_labels)
test_labels = to_categorical(test_labels)
```

- **to_categorical**: Converts integer labels to one-hot encoded vectors for multi-class classification.

### Building the CNN Model

```python
model = models.Sequential()
```

- **Sequential**: Constructs a linear stack of layers.

#### Adding Layers

```python
model.add(layers.Conv2D(32, (3, 3), activation='relu', input_shape=(28, 28, 1)))
```

- **Conv2D**: Adds a convolutional layer with 32 filters, 3x3 kernel size, ReLU activation, and an input shape of (28, 28, 1).

```python
model.add(layers.MaxPooling2D((2, 2)))
```

- **MaxPooling2D**: Down-sampling operation with a 2x2 pooling window.

```python
model.add(layers.Conv2D(64, (3, 3), activation='relu'))
model.add(layers.MaxPooling2D((2, 2)))
model.add(layers.Conv2D(64, (3, 3), activation='relu'))
```

- Additional convolutional and pooling layers for capturing more complex patterns.

#### Fully Connected Layers

```python
model.add(layers.Flatten())
```

- **Flatten**: Converts the 3D feature maps to a 1D feature vector.

```python
model.add(layers.Dense(64, activation='relu'))
```

- **Dense**: Fully connected layer with 64 units and ReLU activation.

```python
model.add(layers.Dense(10, activation='softmax'))
```

- **Dense**: Output layer with 10 units and softmax activation for multi-class classification.

### Compiling the Model

```python
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])
```

- **optimizer='adam'**: Adam optimizer for efficient gradient descent.
- **loss='categorical_crossentropy'**: Loss function for multi-class classification.
- **metrics=['accuracy']**: Metric to evaluate model performance.

### Training the Model

```python
model.fit(train_images, train_labels, epochs=5, batch_size=64, validation_split=0.1)
```

- **fit**: Trains the model for 5 epochs with a batch size of 64 and 10% validation split.

### Evaluating the Model

```python
test_loss, test_acc = model.evaluate(test_images, test_labels)
print(f'Test accuracy: {test_acc}')
```

- **evaluate**: Measures model performance on the test set.
- **test_acc**: Displays the test accuracy.

## Conclusion

This CNN effectively classifies the handwritten digits in the MNIST dataset with high accuracy.
