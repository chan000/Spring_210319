package org.ict.mapper;

import java.util.List;

import org.ict.domain.Criteria;
import org.ict.domain.ReplyVO;
import org.ict.domain.SearchCriteria;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {

	@Autowired
	private ReplyMapper mapper;

	 @Test
	public void testGetList() {
		 log.info(mapper.getList(5));
		 
	}
//	@Test
	public void testCreate() {
		ReplyVO reply = new ReplyVO();
		
		reply.setBno(5);
		reply.setReplytext("추가");
		reply.setReplyer("찬");
		mapper.create(reply);
//		log.info(reply);
	}

}
