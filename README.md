# 코드로 배우는 스프링 웹 프로젝트 - Basic

> 강의 원본은 MySQL 기반이지만, 이 프로젝트는 **PostgreSQL**로 바꿔서 구현했습니다.

---

## 기술 스택

| 분류 | 기술 |
|------|------|
| Framework | Spring Boot |
| ORM | MyBatis |
| DB | PostgreSQL (강의 원본: MySQL) |
| View | JSP + JSTL |
| UI | SB Admin 2 (Bootstrap 4) |
| Build | Gradle |

---

## MySQL → PostgreSQL 주요 변경점

### 1. Auto Increment (시퀀스)

```sql
-- MySQL
bno BIGINT AUTO_INCREMENT PRIMARY KEY

-- PostgreSQL
CREATE SEQUENCE tbl_board_bno_seq;

bno BIGINT DEFAULT nextval('tbl_board_bno_seq') PRIMARY KEY
```

### 2. Mapper XML - 키 조회 방식

```xml
<!-- MySQL: LAST_INSERT_ID() -->
<selectKey order="AFTER" keyProperty="bno" resultType="long">
    SELECT LAST_INSERT_ID()
</selectKey>

<!-- PostgreSQL: AFTER + currval() -->
<selectKey order="AFTER" keyProperty="bno" resultType="long">
    SELECT currval('tbl_board_bno_seq')
</selectKey>
```

### 3. 페이징 쿼리

```sql
-- MySQL
LIMIT #{amount} OFFSET #{skip}

-- PostgreSQL (동일하게 사용 가능)
LIMIT #{amount} OFFSET #{skip}
```

---

## 프로젝트 구조

```
src/main/java/org/zerock/ex00/
├── controller/
│   └── BoardController.java     # 요청 처리 (CRUD + 검색 + 페이징)
├── domain/
│   ├── BoardVO.java             # 게시글 도메인 객체
│   ├── Criteria.java            # 페이징 + 검색 조건
│   └── PageDTO.java             # 페이지 계산 (시작/끝 페이지, prev/next)
├── mappers/
│   └── BoardMapper.java         # MyBatis Mapper 인터페이스
└── services/
    └── BoardService.java        # 비즈니스 로직

src/main/resources/
└── mappers/
    └── BoardMapper.xml          # SQL 쿼리 (동적 검색 포함)

src/main/webapp/WEB-INF/views/board/
├── list.jsp                     # 목록 + 검색 + 페이징
├── read.jsp                     # 상세보기
├── modify.jsp                   # 수정/삭제
└── register.jsp                 # 등록
```

---

## 핵심 기능

### 페이징 (Criteria + PageDTO)

```java
// Criteria: 페이지 번호, 개수, 검색 조건 보관
public int getSkip() {
    return (this.pageNum - 1) * this.amount;
}

// PageDTO: 화면에 보여줄 페이지 번호 계산
this.endPage = (int)(Math.ceil(pageNum / 10.0)) * 10;
this.startPage = this.endPage - 9;
```

### 동적 검색 (MyBatis `<sql>` 재사용)

```xml
<sql id="search">
    <if test="types != null and keyword != null">
        <foreach collection="types" item="type" open=" and (" separator="OR" close=")">
            <choose>
                <when test='type.equals("T")'>title   like concat('%', #{keyword}, '%')</when>
                <when test='type.equals("C")'>content like concat('%', #{keyword}, '%')</when>
                <when test='type.equals("W")'>writer  like concat('%', #{keyword}, '%')</when>
            </choose>
        </foreach>
    </if>
</sql>
```

> 참고: PostgreSQL의 `LIKE`는 대소문자를 구분합니다. 대소문자 구분 없이 검색하려면 `ILIKE`를 사용하세요.

### 검색 조건 유지 (페이지 이동 시)

```jsp
<!-- actionForm에 hidden으로 넣어 페이지 이동/수정/삭제 시 검색 조건 유지 -->
<input type="hidden" name="pageNum" value="${cri.pageNum}">
<input type="hidden" name="amount"  value="${cri.amount}">
<input type="hidden" name="keyword" value="${cri.keyword}">
<c:forEach var="type" items="${cri.types}">
    <input type="hidden" name="types" value="${type}">
</c:forEach>
```

---

## 검색 타입

| 값 | 설명 |
|-----|------|
| `T` | 제목 |
| `C` | 내용 |
| `W` | 작성자 |
| `TC` | 제목 OR 내용 |
| `TW` | 제목 OR 작성자 |
| `TWC` | 제목 OR 작성자 OR 내용 |
