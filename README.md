# Dales Pet Toy Store: Demonstration
## A sample website using MySQL, API’s, JSON, Java Servlets and JSP pages and DHTML.
This simple web system was created as a testing platform to throw automation testing against. Various types of test automation tools now exist, so it is important for the automation tester to have their own web systems that these tools can be trialed against. The website  comprises of the following technology stacks:<br /><br />
**MySQL Backend:** A very simple database called PetToyStore with a single table of pet toys.<br /><br />
**API:** In order for the website front-end to communicate with the server backend, a simple API interface has been created. Called petToyStoreAPI.jsp, the API0\ accepts commands like create and modify to change the state of the MySQL database.<br /><br />
**JSON:** As is common nowadays, the client-server communication occurs using JSON messaging.<br /><br />
**Java Servlets:** The back-end is written using Java Enterprise rules, or servlets. When communicating with the main API, this will in turn access a simple entry servlet which will communicate directly with the backend database.<br /><br />
**JSP pages:** All of the front-end web pages are simple in order to accommodate test automation trials. Two simple JSP pages have been created to show or modify the pet toys within the website, index.jsp and modify.jsp<br /><br />
**Dynamic HTML:** The index and modify web pages use AJAX to fill in the data retrieved from the server-side. This ensures that test automation tools are able to handle newer web 2.0 and web 3.0 technologies, particularly AJAX requests.<br /><br />
