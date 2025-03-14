import random
import math
import numpy as np

class ELM:
    def __init__(self, input_size, hidden_size, output_size):
        self.input_size = input_size
        self.hidden_size = hidden_size
        self.output_size = output_size
        
        # Initialize weights between input layer and hidden layer
        self.weights_input_hidden = [[random.uniform(-1, 1) for _ in range(hidden_size)] for _ in range(input_size)]
        
        # Initialize biases of the hidden layer
        self.bias_hidden = [0] * hidden_size
    
    def train(self, X_train, y_train):
        # Calculate the output of the hidden layer

        hidden_output = self.sigmoid_matrix_multiply(X_train, self.weights_input_hidden, self.bias_hidden)

        # Calculate the weights of the output layer using the pseudo-inverse
        self.weights_hidden_output = self.calculate_pseudo_inverse(hidden_output, y_train)

    
    def predict(self, X_test):

        # Calculate the output of the hidden layer for the test data
        hidden_output = self.sigmoid_matrix_multiply(X_test, self.weights_input_hidden, self.bias_hidden)
        
        # Calculate the output of the output layer
        output = self.matrix_multiply(hidden_output, self.weights_hidden_output)

        # Convert the output to a list of lists of sparse matrices
        # Flatten the list comprehension and convert it to a NumPy array
        y_pred_array = np.array([sparse_matrix.toarray().flatten() for row in output for sparse_matrix in row])

        # Reshape the flattened array to have one row per prediction
        predicted_classes = np.argmax(y_pred_array, axis=1)

        return predicted_classes
    
    def sigmoid(self, x):
        return 1 / (1 + math.exp(-x))
    
    def sigmoid_matrix_multiply(self, X, W, b):
        # Calculate the net input to the hidden layer
        net_hidden = [[sum(X[i][j] * W[j][k] for j in range(self.input_size)) + b[k] for k in range(self.hidden_size)] for i in range(len(X))]
        
        # Apply the sigmoid function to the net input
        return [[self.sigmoid(net_hidden[i][j]) for j in range(self.hidden_size)] for i in range(len(X))]
    
    def calculate_pseudo_inverse(self, X, Y):
        # Calculate the Moore-Penrose pseudo-inverse of the input matrix
        X_transpose = [[X[j][i] for j in range(len(X))] for i in range(len(X[0]))]
        pseudo_inverse = self.matrix_multiply(self.matrix_inverse(self.matrix_multiply(X_transpose, X)), X_transpose)
        
        # Multiply the pseudo-inverse with the target matrix
        return self.matrix_multiply(pseudo_inverse, Y)
    
    def matrix_multiply(self, A, B):
        # Matrix multiplication
        rows_A = len(A)
        cols_A = len(A[0])
        try:
            rows_B = len(B) 
        except:
           rows_B = B.shape[0]  
        try:
            cols_B = len(B[0])
        except:
           cols_B = B[0].shape[0]
        
        if cols_A != rows_B:
            raise ValueError("Number of columns in A must be equal to number of rows in B")
        result = [[0 for _ in range(cols_B)] for _ in range(rows_A)]
        for i in range(rows_A):
            for j in range(cols_B):
                for k in range(cols_A):
                    result[i][j] += A[i][k] * B[k][j]
        return result
    
    def matrix_inverse(self, A):
        # Calculate the inverse of a square matrix using Gaussian elimination
        n = len(A)
        A_inv = [[0 if i != j else 1 for j in range(n)] for i in range(n)]
        for col in range(n):
            # Find pivot
            max_row = max(range(col, n), key=lambda i: abs(A[i][col]))
            A[col], A[max_row] = A[max_row], A[col]
            A_inv[col], A_inv[max_row] = A_inv[max_row], A_inv[col]
            # Make diagonal element 1
            diag = A[col][col]
            for j in range(n):
                A[col][j] /= diag
                A_inv[col][j] /= diag
            # Zero out other elements in the column
            for i in range(n):
                if i != col:
                    ratio = A[i][col]
                    for j in range(n):
                        A[i][j] -= ratio * A[col][j]
                        A_inv[i][j] -= ratio * A_inv[col][j]
        return A_inv
