<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyPage</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.10/css/all.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript">

   function deleteSchedule(schd_idx){
      location.href = "/mypage/remove/"+schd_idx;
   }
   
   function shareSchedule(schd_idx) {
	var user = $('#userShare option:selected').val();
	location.href = "/mypage/share/"+user+"/"+schd_idx;
}
</script>
<script type="text/javascript">
$(function() {
   $('#imgResult').click(function(e) {
      $('#imgFile')[0].click();
   });
});
</script>
</head>
<body>
<div class="container" style="margin-top: 100px;">
   <div class="row">
<div class="col-4">
         <div class="card" style="width: 18rem;">
         
          
             <div id="imgResult">
            <img src="${user.img_path }" class="card-img-top" alt="user profile image">
         </div>
         <form action="imgUpload" name="imgUpload" method="post" enctype="multipart/form-data">
            <input type="file" name="uploadFile" id = "imgFile" class="d-none">
            <button type="submit" class="btn btn-primary float-right">적용</button>
         </form>
            <div class="card-body">
            
               <form role="form" action="/mypage/update" method="post">
                  <div class="form-group">
                     <label>User Index</label> <input class="form-control" name='user_idx'
                           value="${user.user_idx }" readonly="readonly">
                  </div>
                  <div class="form-group">
                        <label>User ID</label> <input class="form-control" name='id'
                           value="${user.id }">
                  </div>
                  <div class="form-group">
                        <label>User PW</label> <input class="form-control" name='pw'
                           value="${user.pw }">
                  </div>
                  <div class="form-group">
                        <label>Email</label> <input class="form-control" name='email'
                           value="${user.email }">
                  </div>
                  <button type="submit" class="btn btn-primary">적용</button>
               </form>
               
            
            </div>
         </div>
      </div>

<div class="col-8">
   <div class="container">
   <h3>내 일정</h3>
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
                     <button type="button" class="btn btn-danger" onclick="deleteSchedule('${schedule.schd_idx }')">
                        <i class="fas fa-trash"></i>
                     </button>
                  </td>
                  <td>
                      <button class="btn btn-primary" onclick="shareSchedule(${schedule.schd_idx });"><i class="fas fa-share-alt"></i></button>
                      	<select id="userShare">
							<c:forEach items="${userList }" var="userList">
							<option id="userShare" value="${userList.user_idx }">${userList.id }
							</c:forEach>
						</select>
                  </td>
                  <td>
                  </td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
      <hr><hr>
   </div>
   <div class="container">
   <h3>공유받은 일정</h3>
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
            <c:forEach items="${shareList }" var="list">
               <tr>
                  <th scope="row" id="schd_idx"><c:out value="${list.schd_idx }"></c:out></th>
                  <td><c:out value="${list.title }"></c:out></td>
                  <td><c:out value="${list.schd_start }"></c:out></td>
                  <td><c:out value="${list.schd_end }"></c:out></td>
                  <td>
                     <button type="button" class="btn btn-danger" onclick="deleteSchedule('${schedule.schd_idx }')">
                        <i class="fas fa-trash"></i>
                     </button>
                  </td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
      </div>
    </div>
    </div>
    </div>
</body>
</html>