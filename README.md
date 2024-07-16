**Network Layer Project - MVVM Architecture with SSL Pinning**

**Introduction**<br />
This project provides a robust network layer using the Model-View-ViewModel (MVVM) architecture pattern, with an emphasis on security through SSL Pinning. It aims to facilitate secure network communication and separation of concerns in your application.

**Architecture**<br />
The project follows the MVVM architecture pattern, ensuring a clear separation between the user interface (View), the business logic (ViewModel), and the data layer (Model). This separation enhances testability, maintainability, and scalability.

**MVVM Components**<br />
Model: Handles the data layer, including network requests and data parsing.
View: Represents the UI components and binds to the ViewModel.
ViewModel: Manages the state and logic, interacting with the Model and updating the View.


**SSL Pinning**<br />
SSL Pinning is implemented to prevent man-in-the-middle attacks by ensuring the app communicates only with trusted servers.

**Features**<br />
MVVM Architecture: Ensures a clean separation of concerns.<br />
Network Layer: Handles API requests and responses efficiently.<br />
SSL Pinning: Enhances security by verifying server certificates.<br />
Error Handling: Comprehensive error handling for network requests.<br />
Dependency Injection: Simplifies testing and decouples components.<br />


**Clone the Repository**<br />
git clone https://github.com/yourusername/network-layer-mvvm-ssl-pinning.git<br />
cd network-layer-mvvm-ssl-pinning

