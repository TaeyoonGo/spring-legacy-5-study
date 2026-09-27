package org.zerock.ex00.service;

import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import org.zerock.ex00.domain.BoardVO;
import org.zerock.ex00.services.BoardService;


@ExtendWith(SpringExtension.class)
@Log4j2
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardServiceTests {

    @Autowired
    BoardService boardService;

    @Test
    public void testList(){
        log.info(boardService.list());
    }


}
