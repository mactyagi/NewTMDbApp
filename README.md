<h2> Setup Instructions </h2>

	1. Create a TMDb Account:
	  • Visit The Movie Database (https://www.themoviedb.org/signup) and create an account if you don’t have one.
	2. Generate an API Key:
	  • Log in to your TMDb account(https://www.themoviedb.org/login) and go to Settings > API.
	  • Request an API key, which is needed to access the movie data. (https://www.themoviedb.org/settings/api)
	3. Configure the API Key:
	  • Copy your TMDb API key.
	  • In the project directory, navigate to Helper Files > NetworkManager.
	  • Add your APIKey in apiKey variable in the code.
	4. Install Dependencies:
	  • The app doesn’t use any external libraries, so there are no additional dependencies to install.

<h2> Assumptions </h2> 

	• Network Restrictions: Some networks, such as Jio in India, may restrict access to TMDb’s services. Users may need to switch to another network if issues arise.
	• API Rate Limiting: TMDb API has rate limits, which means that if the app makes too many requests in a short period, it may temporarily lose access. This is especially important to consider if you’re making frequent requests while testing.
	• Data Availability: It is assumed that the TMDb API provides accurate and up-to-date information. If TMDb makes changes to its data structure, the app may require adjustments.

<h2> Features </h2>

	• Popular Movies List: Displays a list of popular movies fetched from the TMDb API.
	• Movie Details: Shows detailed information about a selected movie, including title, release date, rating, runtime, genres, and a full description.
	• Trailer Link: Includes a link to watch the trailer on YouTube, where available.

<h2> Limitations </h2>

	• Network Compatibility: Known issue with TMDb access on Jio network. Users on this network may experience connectivity issues.
	• API Dependency: The app relies entirely on TMDb for data. If the API is unavailable, the app won’t function as expected.

<h2> Known Constraints </h2>

	• Rate Limiting: TMDb API limits requests, which may affect usability if users refresh frequently.
