<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
      
<%
	String ctxPath = request.getContextPath();
    //     /MyMVC
%>    
 
<style type="text/css">

th {background-color: #DDD}
a#zipcodeSearch {
	
    min-width: 68px;
    padding: 0 10px;
    box-sizing: border-box;
    text-align: center;
    border: 1px solid #ddd;
    border-radius: 0;
    background: #fff;
    font-size: 11px;
    color: #000;
    font-family: inherit;
    transition: all 0.5s;
    cursor:pointer;
}
</style>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("span.error").hide();
		
		// input의 아이디가 email인 경우, 변화가 있는 경우 이벤트를 처리해주는 것이다. 
		$("input#gyoemail").bind("change", ()=>{
			const $target = $(event.target);
			
		    // const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
        	// 또는
          	const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
          	// 이메일 정규표현식 객체 생성
		   
		    const bool = regExp.test($target.val());
		    
			if(!bool) {
				// 이메일이 정규표현식에 위배된 경우  
				$("table#tblMemberRegister :input").prop("disabled", true);
				$target.prop("disabled", false);
				
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();

				$target.focus();
			}
			else {
				// 이메일이 정규표현식에 맞는 경우  
				$("table#tblMemberRegister :input").prop("disabled", false);
				
				//	$target.next().hide();
				// 	또는
					$target.parent().find(".error").hide();
			}
			
			
			}); 
	
		  
		//주소 입력하기 
		$("a#zipcodeSearch").click(function(){
			new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                let addr = ''; // 주소 변수
	                let extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    addr += extraAddr;
	                
	                } else {
	                    addr += extraAddr;
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('gyopostcode').value = data.zonecode;
	                document.getElementById("gyoaddress").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("gyoaddress").focus();
	            }
	        }).open();
		});
		

		
		
		  // === 제출하기
		  $("button#btnEditgyowoninfo").click(function(){		  
			// 글내용 유효성 검사 
			let b_FlagRequiredInfo = false;
		
			$("input.requiredInfo").each(function(index, item){
				const data = $(item).val().trim();
				if(data == "") {
					alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
					b_FlagRequiredInfo = true;
					return false; // for문에서 break;와 같은 기능이다. 
				}
			});
		
			
			// 이메일 중복 검사
			
			
			// 폼(form)을 전송(submit)
			const frm = document.editgyowoninfoFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/editgyowoninfoEnd.lmsfinal";
			frm.submit();
	
		  });
		  
		  
	});// end of $(document).ready(function(){})-------------------------------

	
</script>

  
</head>
<body>


<div style="display: flex; height:1200px;">
	<div style="margin: auto; padding-left: 3%; margin-top: 3%;">

	<form name="editgyowoninfoFrm">
	<h3 style="margin-bottom:30px;">개인정보 조회</h3>
	
	<h5 style="margin-bottom:30px; margin-top:10px;">▶개인 정보</h5>
	<table style="width: 1200px" class="table table-bordered">
		<thead>
			<th colspan="4" style="text-align: center;">개인정보</th>        
		</thead>	
		<tbody>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">이름</th>
			<td>
			<input type="text" name="gyoname" id="gyoname" size="50" value="${requestScope.gyowonvo.gyoname}"/>
			</td>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">이름(영문)</th>
			<td>
			<input type="text" name="gyonameeng" id="gyonameeng" size="50" value="${requestScope.gyowonvo.gyonameeng}" />
			</td>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">아이디</th>
			<td colspan="3"><input type="text" name="gyowonid" id="gyowonid" style="border:none;" size="50" value="${requestScope.gyowonvo.gyowonid}" readonly/>
			
			</td>
		</tr>
		
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">비번</th>
			<td colspan="3">
			<input type="password" name="gyopwd" id="gyopwd" size="50" value=""/>
			</td>
		</tr>
		 
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">핸드폰</th>
			<td colspan="3"><input type="text" name="gyomobile" id="gyomobile" size="50" value="${requestScope.gyowonvo.gyomobile}" />
			
			</td>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">이메일</th>
			<td colspan="3">
			<input type="text" name="gyoemail" id="gyoemail" size="50" value="${requestScope.gyowonvo.gyoemail}" />
			<span class="error">이메일 형식에 맞지 않습니다.</span>
	        <span id="emailCheckResult"></span>
			</td>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">주소</th>
			<td>
			<input type="text" name="gyoaddress" id="gyoaddress" size="50" value="${requestScope.gyowonvo.gyoaddress}" />
			<!-- 주소찾기 버튼  --> 
			</td>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">우편번호</th>
			<td>
			<input type="text" name="gyopostcode" id="gyopostcode" size="30" value="${requestScope.gyowonvo.gyopostcode}" />
			<a  id="zipcodeSearch" class="btnNormal">우편번호 찾기</a>
			</td>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">생년월일</th>
			<td colspan="3">
			<input type="text" name="gyobirthday" id="gyobirthday" size="50" value="${requestScope.gyowonvo.gyobirthday}" />
			<!-- 데이트 피커? -->
			</td>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">국적</th>
			<td colspan="3">
			<input type="text" name="gyonation" id="gyonation" size="50" value="${requestScope.gyowonvo.gyonation}" />
			<!--  select? -->
			</td>
		</tr>
		
		
		</tbody>
	</table>
	
	<h5 style="margin-bottom:30px; margin-top:10px;">▶ 근로 정보</h5>
	<table style="width: 1200px" class="table table-bordered">
		<thead>
			<th colspan="4" style="text-align: center;">근로정보</th>        
		</thead>
		<tbody>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">소속</th>
			<td>${requestScope.gyowonvo.deptname}</td>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">직위</th>
			<td>
			${requestScope.gyowonvo.position}</td>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">근로상태</th>
			<td>
			<c:if test="${requestScope.gyowonvo.workstatus eq 0}">휴직</c:if>
			<c:if test="${requestScope.gyowonvo.workstatus ne 0}">재직</c:if>
			</td>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">임용일자</th>
			<td>${requestScope.gyowonvo.appointmentdt}</td>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">최종학력</th>
			<td colspan="3">
			<input type="text" name="degree" id="degree" size="50" value="${requestScope.gyowonvo.degree}" class="requiredInfo"/>
			</td>
		</tr>
		<tr>
			<th colspan="4" style="text-align: center; background-color: #DDDDDD;">교원경력</th>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">1</th>
			<td>
			<input type="text" name="careerTime1" id="careerTime1" size="50" value="${requestScope.gyowonvo.careerTime1}" class="requiredInfo"/>
			</td>
			<td colspan="2"><input type="text" name="career1" id="career1" size="50" value="${requestScope.gyowonvo.career1}" class="requiredInfo"/>
			</td>
		</tr>
		<tr>
			<th style="width: 15%; text-align: center; background-color: #DDDDDD;">2</th>
			<td>
			<input type="text" name="careerTime2" id="careerTime2" size="50" value="${requestScope.gyowonvo.careerTime2}" class="requiredInfo"/>
			</td>
			<td colspan="2"><input type="text" name="career2" id="career2" size="50" value="${requestScope.gyowonvo.career2}" class="requiredInfo"/>
			</td>
		</tr>
		</tbody>
	
	</table>
	</form>
	
	<div style="margin: 20px;">
		<button type="button" class="btn btn-secondary btn-sm" id="btnEditgyowoninfo">수정완료</button>	
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
	</div>
	

	
</div>
</div>
		
		
		

