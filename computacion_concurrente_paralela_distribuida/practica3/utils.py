from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OneHotEncoder
import numpy as np


# Utilidades paras preprocessar los datos una vez cargados
def rescale_data(X_train, X_test):
    # Rescalar los datos para que tengan media 0 y desviación estándar 1
    X_train = (X_train - np.mean(X_train, axis=0)) / np.std(X_train, axis=0)
    X_test = (X_test - np.mean(X_test, axis=0)) / np.std(X_test, axis=0)

    return X_train, X_test


def prepare_data(X, y, rescale=False, TEST_PERCENTAGE=0.8):

    # Dividir el conjunto de datos en conjuntos de entrenamiento y prueba
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=TEST_PERCENTAGE, random_state=42
    )

    # Convertir las etiquetas a representación one-hot (la red ELM necesita que las etiquetas estén en formato one-hot)
    encoder = OneHotEncoder()
    y_train_onehot = encoder.fit_transform(y_train.reshape(-1, 1))

    if rescale:
        X_train, X_test = rescale_data(X_train, X_test)

    return X_train, X_test, y_train_onehot, y_test


# Utilidades para calcular la precision
def accuracy(y_true, y_pred, target_names=None):

    # Accuracy
    accuracy = np.mean(y_pred == y_true)
    print()
    print(f"Accuracy: {accuracy:.4f}")

    # Per class accuracy
    if target_names is not None:
        print("Per class accuracy:")
        for cls, name in enumerate(target_names):
            idx = np.where(y_true == cls)
            acc = np.mean(y_pred[idx] == y_true[idx])
            print(f"Accuracy class {name}: {acc:.4f}")
