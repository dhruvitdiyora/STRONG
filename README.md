# S.T.R.O.N.G.

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#authors">Authors</a></li> 
    <li><a href="#about-project">About project</a></li>
    <ul>
      <li><a href="#user-story">User story</a></li>   
    </ul>
    <li><a href="#user-diagrams">User diagrams</a></li>   
    <li><a href="#built-with">Built with</a></li>   
    <li><a href="#getting-started">Getting started</a></li>   
    <ul>
      <li><a href="#installation">Installation</a></li>   
      <li><a href="#front-end">Front-end</a></li>   
      <li><a href="#back-end">Back-end</a></li>   
    </ul>
    <li><a href="#users">Users</a></li>   
    <li><a href="#features">Features</a></li>   
    <li><a href="#uniqueness">Uniqueness</a></li>   
    <li><a href="#components">Components</a></li>   
    <li><a href="#color-reference">Color reference</a></li>
    <li><a href="#demo-gif">Demo gif</a></li>
    <li><a href="#made-for">Made for</a></li>   
    <li><a href="#made-with">Made with</a></li>   
    <li><a href="#logo">Logo</a></li>   
  </ol>
</details>

## Authors:
[Dhruvit Diyora](https://www.github.com/dhruvitdiyora), [Piyushsingh Thakur](https://www.github.com/piyusht57), [Preet Gandhi](https://www.github.com/preetgandhi87), [Shubh Patel](https://www.github.com/srp720)

## About project:
![Home-page](https://github.com/dhruvitdiyora/Project_Assets/blob/master/Images/home.png)

The name of the project **S.T.R.O.N.G.** refers to our main idea behind this project. 

**Standing Together Responsibly with ONe Goal** : Let's Serve a Country Mile. 
**S.T.R.O.N.G.** is a social charity website made for helping the underprivileged people of the society by building local communities at micro level of people & organizations who wants to help, which will eventually create a global community of helpful people at macro level.

## User Story:
We've all had a walk/drive through the roads of our cities/villages. 
**One thing which will always be there is,** 
* Someone shivering in the cold nights of winter at the roadside or 
* Someone asking for food/money or
* Little child selling balloons or 
* Someone lacking basic requirements of food/education/shelter/clothes.

We want to help them but maximum we can buy them a meal or give them some money which will last for a night or two. **The problem is** they are going to be there, their needs are going to be there with them as well.

So, the question is, **what you can do?**
* With the help of **S.T.R.O.N.G.** you can click their photo & upload it on the website with their details like, their needs, for how much time they need it, their family-members count, the location will be fetched using your current co-ordinates. 
* Once you post and once the post verification is done, it will be shared with the users living nearby. 
* All the other local users can do is click on the **Visit Now** button, go there & help them. Once the requirement gets fulfilled the post will be closed.

## User Diagrams:
1. [Work-flow](https://drive.google.com/file/d/1LoU8JUT3AiRAB6PrqOKwbXhixboTJKMF/view?usp=sharing)
2. [Data-flow](https://drive.google.com/file/d/1uEey33TIUS6KGZj4JzOcrk9vTFtaHyK0/view?usp=sharing)
3. [User-flow](https://drive.google.com/file/d/1hjy3jZCS8iMBsuTOl0oynqaVpWTX8bXU/view?usp=sharing)
4. [User-function](https://drive.google.com/file/d/1zm1u-pLhnPj8THOP_lq9dOpW6R9buD3X/view?usp=sharing)


## Built with:
**Client side:** [Angular](https://angular.io/), [Bootstrap](https://getbootstrap.com)

**Server side:** [.Net Core](https://dotnet.microsoft.com/en-us/)

**Database side:** [SQL Server](https://www.microsoft.com/en-in/sql-server/)

## Getting Started:
### Installation

_The installation process of front-end and backend of the project._
1. How to get an [API Key](https://cloud.google.com/docs/authentication/api-keys)
2. Clone the repo
   ```
   git clone https://github.com/dhruvitdiyora/STRONG.git
   ```
### Front-end:
3. Install NPM packages
   ```
   npm install
   ```
4. Enter your API in `user-module.ts`
   ```ts
   const API_KEY = 'ENTER YOUR API_KEY';
### Back-end:
5. Open SQL server and create 2 databases - CharityAPI and CharityAuth
6. Run the [SQL scripts](https://github.com/dhruvitdiyora/STRONG/tree/master/CharitySQL)
7. Open `CharityAPI.sln`, it will open whole solution. change connectionStrings in `appsettings.json` and than run project.
    - All API data and parameters can be found in [Postman-Collection](https://github.com/dhruvitdiyora/STRONG/blob/master/CharityAPI/Documents/Postman-Collection/CharityAPI.postman_collection_latest.json)
### Sitemap:
![Sitemap](https://github.com/dhruvitdiyora/Project_Assets/blob/master/Images/sitemap.png)


## Users:
There are 3 users,
1. User/Guest user, 
2. Organisations,
3. Admin panel.

**Guest user can access the post page & organisation view page only, user must login for access to further pages.**

## Features:
###### Create Post/Event:
User can create a post, other users can contribute to it.
Organisation can create an event and all the users can voluntarily join the event.
###### Urgency/Spam:
Users can tap on urgency button if they feel that the post requirement needs to be fulfilled urgently.
Users can tap on spam button if the post includes false information.
###### Share/Save:
Users can tap on share button to share it on other social media platforms.
Users can tap on save button to mark the post as bookmark and open it later.
###### Comment:
The users who are going for the help can comment and update the post requirements.
###### Visit now:
Visit now button leads to the exact location of the need in Google maps, through which you can go there and help them.
###### Cluster:
If the need is coming frequently, we can add it to the cluster location, with its details like location, family count, requirement type.
If a user wants to donate something directly, he/she can simply choose the nearby cluster locations for it. An organisation can identify the clusters based on its events.
###### Charity event/Event post:
Organisation can create a charity event, which includes event description, event start date- end date. Volunteers of that organisation and other users can join the event and participate in it and post about their activity in the event. 
###### Join now+:
If a user wants to join an organisation he/she can tap the join now button and can become part of it.
###### User-profile:
Tapping on a username/user icon will lead you to the profile of the user. Which will display his/her contributions.

## Uniqueness:
There are many NGOs & websites working for the welfare of underprivileged people, what makes **S.T.R.O.N.G.** unique is,
-	Zero funds policy of donation,
-	Users who are helping can feel that personal satisfaction also 100% transparency with their contribution as they know where it is going.
-	Location restrictions, which fetches the live location co-ordinates of the user so that false posts can be prevented.
-	Urgency-Spam-Comment feature, for smooth handling of a post all 3 features are required, as High urgency posts i.e., medical emergency will be shown to the local users on prior bases. Spam reported posts will be evaluated by admin and will be deleted. Comment feature will let other user know-guide for further contribution.
-	By doing so, it will build a **S.T.R.O.N.G.** community which can raise hands together for helping  the needy ones at any time & any place.

## Components:
- Login-Signup-Logout component,
- Home/post component,
- Create post component,
- Post detail component,
- Organisation list component,
- Organisation info component,
- Organisation volunteer component,
- Organisation event component,
- Event info component,
- Event post component,
- Create event/event-post component,
- Cluster component,
- About us component,
- User profile component,
- Admin component.

## Color Reference:
| Color             | Hex                                                                |
| ----------------- | ------------------------------------------------------------------ |
| Navbar | ![#000000](https://via.placeholder.com/10/000000?text=+) #000000 |
| Navbar-text | ![#f10000](https://via.placeholder.com/10/f10000?text=+) #f10000 |
| Sidebar | ![#212529](https://via.placeholder.com/10/212529?text=+) #212529 |
| Post feed | ![#ffffff](https://via.placeholder.com/10/ffffff?text=+) #ffffff |
| Login-Signup | ![#f0f5ff](https://via.placeholder.com/10/f0f5ff?text=+) #f0f5ff |

## Demo gif:

## Made for:
- **Underprivileged people:** Who need help,
- **Normal people-Organisations:** Who wants to help.
## Made with: 
### [RadixWeb](https://radixweb.com/)

## Logo:
![Logo](https://github.com/dhruvitdiyora/Project_Assets/blob/master/Images/logo_strong_BG.png)

