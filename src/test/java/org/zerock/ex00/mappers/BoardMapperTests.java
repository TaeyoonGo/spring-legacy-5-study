package org.zerock.ex00.mappers;

import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.ex00.domain.BoardVO;
import org.zerock.ex00.domain.Criteria;


@ExtendWith(SpringExtension.class)
@Log4j2
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardMapperTests {


    @Autowired(required = false)
    BoardMapper boardMapper;

    @Test
    public void test1() {
        log.info(boardMapper);
    }

    @Test
    public void testList() {
        boardMapper.getList().forEach(BoardVo -> log.info(BoardVo));
    }


    @Test
    public void testInsert() {
        BoardVO boardVO = new BoardVO();
        boardVO.setTitle("NewTest");
        boardVO.setContent("new Test...");
        boardVO.setWriter("newbie");

        boardMapper.insert(boardVO);

        log.info("COUNT: " + boardMapper.insert(boardVO));
        log.info("BNO: " + boardVO.getBno());
    }


    @Test
    public void testUpdate() {
        BoardVO boardVO = new BoardVO();
        boardVO.setTitle("update Title");
        boardVO.setContent("update Content");
        boardVO.setBno(9L);

        int updateCount = boardMapper.update(boardVO);

        log.info("update: " + updateCount);
    }

    @Test
    public void testPage() {
        Criteria criteria = new Criteria();
        // 1 , 10
        criteria.setPageNum(2);
        criteria.setTypes(new String[]{"T","C","W"});
        criteria.setKeyword("a");

        java.util.List<BoardVO> list = boardMapper.getPage(criteria);


        list.forEach(boardVO -> log.info(boardVO));
    }
}
