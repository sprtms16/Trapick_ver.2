<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	
	<header>
		<script type="text/javascript">
			$(function(){
				$('.fa-bell')
			})
		</script>
	</header>
<nav class="navbar navbar-expand navbar-dark bg-info fixed-top">
  <a class="navbar-brand" href="#">Feed</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample02" aria-controls="navbarsExample02" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarsExample02">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">my page <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">PARK GWANYONG</a>
      </li>
    </ul>
    <span style="font-size: 1.7em;">
  <i class="fas fa-bell"><span style="font-size: 1rem; color: red"></span></i>
</span>
   
   <div class="search_menu">
			<form action="list" method="get">
				<aside style="float: right;">
					<input type="text" name="word" placeholder="검색">
					<button type="submit">확인</button>

				</aside>
			</form>
		</div>
  </div>
</nav>