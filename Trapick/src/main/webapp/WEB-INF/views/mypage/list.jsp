<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyPage</title>
<link rel="stylesheet"
   href="https://use.fontawesome.com/releases/v5.0.10/css/all.css">
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
   src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<<<<<<< HEAD
<style type="text/css">
     /* The Modal (background) */
    .modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgb(0,0,0); /* Fallback color */
        background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }

    /* Modal Content/Box */
    .modal-content {
        background-color: #fefefe;
        margin: 15% auto; /* 15% from the top and centered */
        padding: 20px;
        border: 1px solid #888;
        width: 50%; /* Could be more or less, depending on screen size */                          
    }
    /* The Close Button */
    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }
    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }
</style>
<script type="text/javascript">

//Get the modal
var modal = document.getElementById('myModal');

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];                                          

// When the user clicks on the button, open the modal 
 btn.onclick = function() {
    modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

   function deleteSchedule(schd_idx){
      location.href = "/mypage/remove/"+schd_idx;
   }
   
   function shareSchedule(user,schd_index) {
	alert("dasdfa"+schd_index);
	location.href = "/mypage/share/"+user+"/"+schd_idx;
	}
   
   	function openWin(schd_index) {
	    modal.style.display = "block";
		
	}
</script>
</head>
<body>


   <h2>회원 정보</h2>
   <div class="user">
      <ul>
         <li>Idx ${user.user_idx }</li>
         <li>ID ${user.id }</li>
         <li>PW ${user.pw }</li>
         <li>Email ${user.email }</li>
      </ul>

   </div>
   
   


   <h2>마이페이지</h2>

   <div class="container">
      <table class="table table-hover">
         <thead>
            <tr>
               <th scope="col">번호</th>
               <th scope="col">제목</th>
               <th scope="col">출발일</th>
               <th scope="col">도착일</th>
               <th scope="col"></th>
               <th scope="col"></th>
            </tr>
         </thead>
         <tbody>
            <c:forEach items="${list }" var="schedule">
               <tr>
                  <th scope="row" id="schd_idx"><c:out value="${schedule.schd_idx }"></c:out></th>
                  <c:set var = "schd_index" value="${schedule.schd_idx }"/>
                  <td><c:out value="${schedule.title }"></c:out></td>
                  <td><c:out value="${schedule.schd_start }"></c:out></td>
                  <td><c:out value="${schedule.schd_end }"></c:out></td>
                  <td>
                     <button type="button" class="btn btn-danger" 
                        onclick="deleteSchedule(schd_index)">
                        <i class="fas fa-trash"></i>
                     </button>
                  </td>
                  <td>
<%--                      <button type="button" class="btn btn-primary" onclick="shareSchedule(4,'${schedule.schd_idx }')">
                        <i class="fas fa-share-alt"></i>
                     </button> --%>
                   <input id="shareBtn" value ="공유" type="button" onclick="openWin('${schedule.schd_idx }');">
                   <%-- <button id="myBtn" class="btn btn-primary" onclick="openWin("${schedule.schd_idx }");"><i class="fas fa-share-alt"></i></button> --%>
                  </td>
                  <td>
                  </td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
      
          <!-- Trigger/Open The Modal -->
    <button id="myBtn">Open Modal</button>
 
    <!-- The Modal -->
    <div id="myModal" class="modal">
 
      <!-- Modal content -->
      <div class="modal-content">
        <span class="close">&times;</span>                                                               
        <p>Some text in the Modal..</p>
      </div>
 
    </div>
      
 
<%--     <!-- The Modal -->
    <div id="myModal" class="modal">
 
      <!-- Modal content -->
      <div class="modal-content">
      <form>            
	       <c:forEach items="${userList }" var="userList">
	       	<input type = "radio" name = "checkUser" value="${userList.user_idx }">${userList.user_idx }       
	       </c:forEach>
	       <c:forEach items="${list }" var="schedule">
	       	<input type="hidden" name = "schd_idx" value="${schedule.schd_idx }">
	       </c:forEach>
	       <button type="button" class="btn btn-primary" onclick="shareSchedule(4,'${schd_idx }')">공유</button>
	  </form>
      </div> 
    </div> --%>
=======
<script type="text/javascript">

   function deleteSchedule(schd_idx){
      location.href = "/mypage/remove/"+schd_idx;
   }
   
   function shareSchedule(user,schd_idx) {
	   alert(schd_idx);
	location.href = "/mypage/share/"+user+"/"+schd_idx;
}
</script>
<script type="text/javascript">
$(function() {
	

// Get the modal
var modal = document.getElementById('myModal');

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];                                          

// When the user clicks on the button, open the modal 
 btn.onclick = function() {
		alert("ddd");
		alert($(this).parent().find('#schd_idx'));
    modal.style.display = "block";
}


// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
})
</script>
<style type="text/css">
        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
    
        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 50%; /* Could be more or less, depending on screen size */                          
        }
        /* The Close Button */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
</style>
</head>
<body>


   <h2>회원 정보</h2>
   <div class="user">
      <ul>
         <li>Idx ${user.user_idx }</li>
         <li>ID ${user.id }</li>
         <li>PW ${user.pw }</li>
         <li>Email ${user.email }</li>
      </ul>

   </div>

   <div class="card" style="width: 18rem;">
      <img src="..." class="card-img-top" alt="...">
      <div class="card-body">
         <h5 class="card-title">회원 정보</h5>
         <p class="card-text">
            
         </p>
         <a href="#" class="btn btn-primary">수정</a>
      </div>
   </div>

   <h2>마이페이지</h2>

   <div class="container">
      <table class="table table-hover">
         <thead>
            <tr>
               <th scope="col">번호</th>
               <th scope="col">제목</th>
               <th scope="col">출발일</th>
               <th scope="col">도착일</th>
               <th scope="col"></th>
               <th scope="col"></th>
            </tr>
         </thead>
         <tbody>
            <c:forEach items="${list }" var="schedule">
               <tr>
                  <th scope="row" id="schd_idx"><c:out value="${schedule.schd_idx }"></c:out></th>
                  <td><c:out value="${schedule.title }"></c:out></td>
                  <td><c:out value="${schedule.schd_start }"></c:out></td>
                  <td><c:out value="${schedule.schd_end }"></c:out></td>
                  <td>
                     <button type="button" class="btn btn-danger" 
                        onclick="deleteSchedule('${schedule.schd_idx }')">
                        <i class="fas fa-trash"></i>
                     </button>
                  </td>
                  <td>
<%--                      <button type="button" class="btn btn-primary" onclick="shareSchedule(4,'${schedule.schd_idx }')">
                        <i class="fas fa-share-alt"></i>
                     </button> --%>
                     	
                        <button id="myBtn" class="btn btn-primary"><i class="fas fa-share-alt"></i></button>
                  </td>
                  <td>
                  </td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
 
    <!-- The Modal -->
    <div id="myModal" class="modal">
 
      <!-- Modal content -->
      <div class="modal-content">
      <form>            
	       <c:forEach items="${userList }" var="userList">
	       	<input type = "radio" name = "checkUser" value="${userList.user_idx }">${userList.user_idx }       
	       </c:forEach>
	       <c:forEach items="${list }" var="schedule">
	       	<input type="hidden" name = "schd_idx" value="${schedule.schd_idx }">
	       </c:forEach>
	       <button type="button" class="btn btn-primary" onclick="shareSchedule(4,'${schd_idx }')">공유</button>
	  </form>
      </div>
 
    </div>
>>>>>>> branch 'master' of https://github.com/sprtms16/Trapick_ver.2.git
      
      
   </div>
</body>
</html>