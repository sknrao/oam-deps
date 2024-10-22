/*-
 * ============LICENSE_START=======================================================
 * openECOMP : SDN-C
 * ================================================================================
 * Copyright (C) 2017 AT&T Intellectual Property. All rights
 *                             reserved.
 * ================================================================================
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ============LICENSE_END=========================================================
 */

package com.onap.sdnc.testapi.model;

import static org.junit.Assert.assertEquals;
import org.junit.Before;
import org.junit.Test;
import org.mockito.MockitoAnnotations;
import com.onap.sdnc.reports.model.PreTestResponse;

public class PreTestResponseTest {

	private String ipaddress = "0.0.0.0";
	private String avgTime = "Minimum = 0ms";
	private String statistics = "0% loss";
	private String testtype = "network";

	PreTestResponse preTestResponse = new PreTestResponse();

	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
	}

	@Test
	public void TestPreTestResponse() {

		preTestResponse.setAvgTime(avgTime);
		preTestResponse.setIpaddress(ipaddress);
		preTestResponse.setStatistics(statistics);
		preTestResponse.setStatus("reachable");
		preTestResponse.setTesttype(testtype);

		assertEquals(preTestResponse.getAvgTime(), avgTime);
		assertEquals(preTestResponse.getIpaddress(), ipaddress);
		assertEquals(preTestResponse.getStatistics(), statistics);
		assertEquals(preTestResponse.getStatus(), "reachable");
		assertEquals(preTestResponse.getTesttype(), testtype);
	}
}