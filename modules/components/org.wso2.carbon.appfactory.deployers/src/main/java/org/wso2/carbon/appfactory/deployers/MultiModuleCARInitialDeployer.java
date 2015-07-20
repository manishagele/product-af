/*
 * Copyright (c) 2014, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *    WSO2 Inc. licenses this file to you under the Apache License,
 *    Version 2.0 (the "License"); you may not use this file except
 *    in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing,
 *   software distributed under the License is distributed on an
 *   "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *   KIND, either express or implied.  See the License for the
 *   specific language governing permissions and limitations
 *   under the License.
 */
package org.wso2.carbon.appfactory.deployers;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.wso2.carbon.appfactory.common.AppFactoryConstants;
import org.wso2.carbon.appfactory.common.AppFactoryException;
import org.wso2.carbon.appfactory.common.util.AppFactoryUtil;

import java.io.File;
import java.util.Map;

/**
 * Created for initial deployment of car apptype.
 */
public class MultiModuleCARInitialDeployer extends InitialArtifactDeployer {

	private static final Log log = LogFactory.getLog(MultiModuleCARInitialDeployer.class);

	public MultiModuleCARInitialDeployer(Map<String, String[]> parameters, int tenantId, String tenantDomain) {
		super(parameters, tenantId, tenantDomain);
	}

	/**
	 * This method will be used to retrieve the artifact in the given path filtered by extension.
	 *
	 * @param path      The path were artifact has been stored
	 * @param extension Artifact file extension
	 * @return Array of artifacts as Files
	 * @throws org.wso2.carbon.appfactory.common.AppFactoryException If there is an issue in filtering artifacts
	 */
	protected File[] getArtifact(String path, String extension, String stage, String applicationId, boolean isForLabel) throws AppFactoryException {
		stage = AppFactoryUtil.getAppfactoryConfiguration().
				getFirstProperty(AppFactoryConstants.AF_CONFIGURATION_INITIAL_STAGE_TAG_NAME);
		return  AppFactoryUtil.getArtifact(path, extension, stage, applicationId, isForLabel);
	}
}
