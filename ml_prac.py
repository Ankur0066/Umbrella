
from sklearn.linear_model import LinearRegression
from sklearn.datasets import load_diabetes
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
import seaborn as sns
X, y = load_diabetes(return_X_y=True)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
model = LinearRegression().fit(X_train, y_train)
print("The Accuracy Score is ",model.score(X_test, y_test))
sns.regplot(x=y_test, y=model.predict(X_test))

from sklearn.linear_model import LogisticRegression
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
X, y = load_iris(return_X_y=True)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
model = LogisticRegression().fit(X_train, y_train)
print("The Accuracy Score is ",model.score(X_test, y_test))
plt.scatter(X_test[:, 0], X_test[:, 1], c=model.predict(X_test))
plt.show()

from sklearn.tree import DecisionTreeClassifier, plot_tree
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
X, y = load_iris(return_X_y=True)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
model = DecisionTreeClassifier().fit(X_train, y_train)
print("The Accuracy Score is ",model.score(X_test, y_test))
plot_tree(model)
plt.show()

from xgboost import XGBClassifier
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
X, y = load_iris(return_X_y=True)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
model = XGBClassifier().fit(X_train, y_train)
print("The Accuracy Score is ",model.score(X_test, y_test))
plt.scatter(X_test[:, 0], X_test[:, 1], c=y_test)
plt.show()

from sklearn.svm import SVC
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
X, y = load_iris(return_X_y=True)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
model = SVC().fit(X_train, y_train)
print("The Accuracy Score is ",model.score(X_test, y_test))
plt.scatter(X_test[:, 0], X_test[:, 1], c=y_test)
plt.show()

from sklearn.cluster import DBSCAN
from sklearn.datasets import make_blobs
import matplotlib.pyplot as plt
X, _ = make_blobs(n_samples=100, centers=3, n_features=2)
model = DBSCAN().fit(X)
n_clusters = len(set(model.labels_)) - (1 if -1 in model.labels_ else 0)
print(f'Number of clusters: {n_clusters}')
plt.scatter(X[:, 0], X[:, 1], c=model.labels_)
plt.show()
