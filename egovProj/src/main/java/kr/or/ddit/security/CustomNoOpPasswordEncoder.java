package kr.or.ddit.security;

import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.slf4j.Slf4j;

/* 비밀전호 암호화 처리기 클래스
     - 스프링 시큐리티 5버전부터 기본적으로PasswordEncoder를 지정해야 함 
 	 - users 테이블의 password 컬럼의 값들은 암호화 처리가 되어있지 않음
 	 - 연습용이므로 암호화를 하지 않는 PasswordEncoder를 직접 구현하여
 	 	암호화를 고려하지 않고 테스팅을 해보자
 */
@Slf4j
public class CustomNoOpPasswordEncoder implements PasswordEncoder {@Override
	public String encode(CharSequence rawPassword) {
		log.warn("before encode : " + rawPassword);
		return rawPassword.toString();
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		log.info("matches : " + rawPassword + " : " + encodedPassword);
		//로그인 할 때 입력된 비밀번호와 DB상의 비밀번호를 match 시켜봄
		return rawPassword.toString().equals(encodedPassword);
	}
	
}
