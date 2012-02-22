#
# Copyright (C) 2011 Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "layouts/application" do
  it "should render" do
    assigns[:domain_root_account] = Account.default
    render "layouts/application"
  end

  it "should include site admin css" do
    account = Account.site_admin
    account.settings[:global_includes] = true
    account.settings[:global_stylesheet] = 'somewhereoutthere'
    account.save!
    assigns[:domain_root_account] = Account.default
    render "layouts/application"
    response.body.should match /somewhereoutthere/
  end

  it "should include site admin css once" do
    account = Account.site_admin
    account.settings[:global_includes] = true
    account.settings[:global_stylesheet] = 'somewhereoutthere'
    account.save!
    assigns[:domain_root_account] = Account.site_admin
    render "layouts/application"
    response.body.should match /somewhereoutthere/
    response.body.scan(/somewhereoutthere/).length.should == 1
  end
end