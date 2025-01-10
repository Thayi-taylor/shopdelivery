<%@ page contentType="application/json;charset=UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="org.json.*" %>

<%
    String query = request.getParameter("query");

    if (query != null && !query.trim().isEmpty()) {
        String apiURL = "https://openapi.naver.com/v1/search/local.json?query=" + URLEncoder.encode(query, "UTF-8") + "&display=10";

        try {
            HttpURLConnection con = (HttpURLConnection) new URL(apiURL).openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", "k1IcrZXdoOilmpmM1Mfu");
            con.setRequestProperty("X-Naver-Client-Secret", "sNnATBJGA1");
            con.setRequestProperty("Content-Type", "application/json");

            int responseCode = con.getResponseCode();
            BufferedReader br;
            if (responseCode == 200) { // 성공
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else { // 실패
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            StringBuilder apiResponse = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                apiResponse.append(line);
            }
            br.close();

            // JSON 형식으로 응답 반환
            out.clear(); // 기존 JSP 출력 내용 제거
            out.print(apiResponse.toString());
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            out.clear();
            out.print("{\"error\": \"API 요청 중 오류가 발생했습니다.\"}");
            out.flush();
        }
    } else {
        out.clear();
        out.print("{\"error\": \"검색어를 입력하세요.\"}");
        out.flush();
    }
%>
