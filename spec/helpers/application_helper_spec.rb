require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do
  describe "email address helpers" do
    before do
      @username = "calicoder"
      @itemname = "great-red.couch_new"
      @tag = "22-33_44.55"
      @message = "Hey there buddy!\n\n-- \nAndrew Shin\n\nSent with Sparrow"
      @craigslist_footer = "\n-----------------------------------------------------------------\nthis message was remailed to you via: sale-jzthh-2445049008@craigslist.org\n------------------------------------------------------------------"
    end

    describe "#user_name_from_email(email)" do
      it "should return user name from email address" do
        email = "#{@itemname}@#{@username}.craigskit.com"
        user_name_from_email(email).should == @username
      end

      it "should return user name from email address with brackets" do
        email = "<#{@itemname}@#{@username}.craigskit.com>"
        user_name_from_email(email).should == @username
      end

      it "should return nil if user name is not on email address" do
        email = "<#{@itemname}@craigskit.com>"
        user_name_from_email(email).should == nil
      end

      it "should return nil if user name is not on email address" do
        email = "randomemailthatsucks"
        user_name_from_email(email).should == nil
      end
    end

    describe "#alias_from_email(email)" do
      it "should return the item name from email address" do
        email = "#{@itemname}@#{@username}.craigskit.com"
        alias_from_email(email).should == @itemname
      end

      it "should return the item name from email address with brackets" do
        email = "<#{@itemname}@#{@username}.craigskit.com>"
        alias_from_email(email).should == @itemname
      end

      it "should return the item name from email address with '+' tag" do
        email = "<#{@itemname}+#{@tag}@#{@username}.craigskit.com>"
        alias_from_email(email).should == @itemname
      end

      it "should return nil alias cannot be found in email" do
        email = "randomemailthatsbroken"
        alias_from_email(email).should == nil
      end
    end

    describe "#listing_title_from_subject(subject)" do
      it "should return the listing title from subject" do
        title = "iPad2 White, 16 GB, Wi-fi Only"
        subject = 'craigslist post 2425310227: "' + title + '"'
        listing_title_from_subject(subject).should == title
      end

      it "should return the listing title from subject with quotes" do
        title = 'iPad2 "White", 16 GB, Wi-fi Only'
        subject = 'craigslist post 2425310227: "' + title + '"'
        listing_title_from_subject(subject).should == title
      end

      it "should return nil if the listing title is not in the subject" do
        subject = 'hot hot hot subjects yo'
        listing_title_from_subject(subject).should == nil
      end

      it "should return the listing title from subject for anonymous listings" do
        title = 'New MacBook Pro 17 in, i7, 2.2 Ghz'
        subject = 'POST/EDIT/DELETE : "' + title + '" (electronics)'
        listing_title_from_subject(subject).should == title
      end
    end

    describe "#listing_title_from_subject(subject)" do
      before do
        @title = "iPad2 White, 16 GB, Wi-fi Only"
      end

      it "should return the listing title from subject" do
        subject = 'craigslist post 2425310227: "' + @title + '"'
        listing_title_from_subject(subject).should == @title
      end

      it "should return the listing title from subject for non logged in listings" do
        subject = 'POST/EDIT/DELETE : "' + @title + '"' + " (electronics)"
        listing_title_from_subject(subject).should == @title
      end

      it "should return the listing title from subject for non logged in listings" do
        subject = 'POST/EDIT/DELETE : "' + @title + '"' + " (electronics)"
        listing_title_from_subject(subject).should == @title
      end

      it "should return the listing title from subject for non logged in listings without category" do
        subject = 'POST/EDIT/DELETE : "' + @title + '"' + " (electronics)"
        listing_title_from_subject(subject).should == @title
      end

      it "should return the listing title from subject with quotes" do
        subject = 'craigslist post 2425310227: "' + @title + '"'
        listing_title_from_subject(subject).should == @title
      end

      it "should return nil if the listing title is not in the subject" do
        subject = 'hot hot hot subjects yo'
        listing_title_from_subject(subject).should == nil
      end
    end

    describe "#listing_title_from_subject_in_inquiry(subject)" do
      it "should return the listing title from subject" do
        title = "iPad2 White, (16 GB), Wi-fi Only"
        subject = title + " (SOMA / south beach) $525"
        listing_title_from_subject_in_inquiry(subject).should == title
      end

      it "should return nil if not matching" do
        subject = "dood i want yo shit!"
        listing_title_from_subject_in_inquiry(subject).should == nil
      end

      it "should return nil if the listing title is not in the subject" do
        subject = 'hot hot hot subjects yo'
        listing_title_from_subject(subject).should == nil
      end
    end

    describe "#listing_url_from_body(body)" do
      it "should return the listing url from body" do
        url = 'http://sfbay.craigslist.org/sfc/ele/2425310227.html'
        body = 'Posting ID # 2425310227: \r\n "iPad2 White, 16 GB, Wi-fi Only" (electronics) \r\n Should now be viewable at the following URL: ' + url + ' \r\n More more more'
        listing_url_from_body(body).should == url
      end
      it "should return the listing url from body" do
        url = 'http://sfbay.craigslist.org/sfc/ele/2425310227.html'
        body = "** CRAIGSLIST ADVISORY --- AVOID SCAMS BY DEALING LOCALLY\n** Avoid:  wiring money, cross-border deals, work-at-home\n** Beware: cashier checks, money orders, escrow, shipping\n** More Info:  http://www.craigslist.org/about/scams.html\n\nHello, may I get the serial number? \n\nThanks. \n\n" + url + " \n\nSent from Craigslist Mobile for iPhone\n\n\n- Sent from my iPod\n\n------------------------------------------------------------------\nThis message was remailed to you via: sale-gepty-2530728416@craigslist.org\nIf this email is a scam or spam please flag it now:\nhttp://www.craigslist.org/flag/?flagCode=31&smtpid=20110805064507Vi4ndS6_4BGZM0T7y-JfHQ\n------------------------------------------------------------------"
        listing_url_from_body(body).should == url
      end

      it "should return nil if the listing url is not in the body" do
        body = 'some hot body'
        listing_url_from_body(body).should == nil
      end


      it "should not return the scam URL" do
        url = "http://www.craigslist.org/about/scams.html"
        body = 'Posting ID # 2425310227: \r\n "iPad2 White, 16 GB, Wi-fi Only" (electronics) \r\n Should now be viewable at the following URL: ' + url + ' \r\n More more more'
        listing_url_from_body(body).should == nil
      end
    end

    describe "#listing_number_from_subject(subject)" do
      it "should return the listing number from subject" do
        number = '123456789'
        subject = 'craigslist post ' + number + ': "iPad2 "White", 16 GB, Wi-fi Only"'
        listing_number_from_subject(subject).should == number
      end

      it "should return nil if the listing number is not in the subject" do
        subject = 'some random subject'
        listing_number_from_subject(subject).should == nil
      end
    end

    describe "#listing_number_from_body(body)" do
      it "should return the listing number from body" do
        number = '123456789'
        body = 'this is a bunch of body then there is an url from craigslist http://sfbay.craigslist.org/sfc/ele/' + number + '.html and then there was this and that'
        listing_number_from_body(body).should == number
      end

      it "should return nil if body does not have listing number" do
        body = 'some body that odesnt have a listing number'
        listing_number_from_body(body).should == nil
      end
    end

    describe "listing_number_from_email(email)" do
      it "should return listing number from email" do
        listing_number = "2425310227"
        email = "sale-h9htu-" + listing_number + "@craigslist.org"
        listing_number_from_email(email).should == listing_number
      end

      it "should return nil if there is no listing number" do
        email = "somerandomemail@craigslist.org"
        listing_number_from_email(email).should == nil
      end
    end

    describe "message_only_from_body" do
      it "should message only from body" do
        @body_plain = @message + "\n\nOn Sunday, June 12, 2011 at 4:34 AM, Andrew Shin wrote:\nHello 2\n\nOn Sunday, June 11, 2011 at 4:34 AM, Andrew Shin wrote:\nHello 3\n"
        message_only_from_body(@body_plain).should == @message
      end

      it "should message only from body" do
        @body_plain = @message + "\n\nOn 6/15/11 5:39 PM, Andrew Shin wrote:\nHello 2\n"
        message_only_from_body(@body_plain).should == @message
      end

      it "should message only from body" do
        @body_plain = @message + "\n\nOn Wed, Jun 15, 2011 at 5:35 PM, Billy Chasen <help@turntable.fm> wrote:\nHello 2\n"
        message_only_from_body(@body_plain).should == @message
      end

      it "should message only from body" do
        @body_plain = @message + "\n\nOn Jul 22, 2011 at 5:35 PM, dood@turdsky.com wrote:\nHello 2\n"
        message_only_from_body(@body_plain).should == @message
      end

      xit "should message only from body" do
        @body_plain = @message + "\n\n--- On Wed, 6/29/11, calicoder@calicoder.craigskit.com wrote: \nHello 2\n"
        message_only_from_body(@body_plain).should == @message
      end

      it "should not remove message only from body" do
        @body_plain = @message + "\n\nOn Jul 22, 2011 at 5:35 PM, dood@turdsky.com wrote:\nHello 2\n"
        message_only_from_body(@body_plain).should == @message
      end
    end

    describe "remove_craigslist_warning_from_body" do
      it "should remove warning from body" do
        cl_message = "** CRAIGSLIST ADVISORY --- AVOID SCAMS BY DEALING LOCALLY\n** Avoid:  wiring money, cross-border deals, work-at-home\n** Beware: cashier checks, money orders, escrow, shipping\n** More Info:  http://www.craigslist.org/about/scams.html\n\n"
        @body_plain = cl_message + @message
        remove_craigslist_warning_from(@body_plain).should == @message
      end
    end

    describe "trim_new_lines" do
      it "should string leading and trailing new lines from body" do
        @body_plain = "\n\n\n\n\n" + @message + "\n\n\n\n"
        trim_new_lines(@body_plain).should == @message
      end
    end

    describe "remove_craigslist_footer_from" do
      it "should remove footer from body" do
        cl_message = "\n------------------------------------------------------------------\nThis message was remailed to you via: sale-e5ufx-2517050142@craigslist.org\nIf this email is a scam or spam please flag it now:\nhttp://www.craigslist.org/flag/?flagCode=31&smtpid=20110728054207Am7mVNy44BG3LOPkngSXLA\n------------------------------------------------------------------"
        @body_plain = @message + cl_message
        remove_craigslist_footer_from(@body_plain).should == @message
      end

      it "should not remove footer from body if does not exist" do
        remove_craigslist_footer_from(@message).should == @message
      end

      it "should string leading and trailing new lines from body for other footer" do
        @body_plain = @message + @craigslist_footer
        remove_craigslist_footer_from(@body_plain).should == @message
      end
    end

    describe "wash_that_body" do
      it "should clean up the string" do
        cl_message = "** CRAIGSLIST ADVISORY --- AVOID SCAMS BY DEALING LOCALLY\n** Avoid:  wiring money, cross-border deals, work-at-home\n** Beware: cashier checks, money orders, escrow, shipping\n** More Info:  http://www.craigslist.org/about/scams.html\n\n"
        forward = "\n\nOn Wed, Jun 15, 2011 at 5:35 PM, Billy Chasen <help@turntable.fm> wrote:\nHello 2\n"
        @body_plain = cl_message + @message + @craigslist_footer + forward
        wash_that_body(@body_plain).should == @message
      end
    end

    describe "price_from(subject)" do
      it "should return price" do
        price = "$85"
        subject = "Epson Stylus NX420 Wifi Printer, Scanner, Copier - " + price + " (San Francisco)"
        price_from(subject).should == price
      end
    end

    describe "location_from(subject)" do
      it "should return the location" do
        location = "San Francisco"
        subject = "Epson Stylus NX420 Wifi Printer, Scanner, Copier - $85 (" + location + ")"
        location_from(subject).should == location
      end
    end
  end

  describe "manage_url_from_body(body)" do
    it "should return manage url from body" do
      manage_url = 'https://post.craigslist.org/u/-CkRzs.K4_4~B:?#@!$&()*+,-=G_a*bRwY=u;ZNriQ/i6rrv'
      body = "\r\nIMPORTANT - YOU MUST TAKE FURTHER ACTION TO PUBLISH THIS POST !!!\r\n\r\nCLICK ON THE WEB ADDRESS BELOW TO PUBLISH, EDIT, OR DELETE THIS\r\nPOSTING.\r\n\r\nIf your email program doesn't recognize the web address below as an\r\nactive link, please copy and paste the following address into your web\r\nbrowser:\r\n\r\n" + manage_url + "\r\n\r\nPLEASE KEEP THIS EMAIL - you will need it to publish and manage your\r\nposting!\r\n\r\nYour posting will expire off the site 7 days after it was created.\r\n\r\n\r\nWARNING!! *** WARNING!! *** WARNING!! *** WARNING!!\r\nPlease be wary of distant 'buyers' responding to your ad! Many\r\nsellers receive replies from scammers hoping to defraud them through\r\nschemes involving counterfeit cashier's checks and/or wire transfers.\r\nThese checks will clear the bank, but the person cashing the check will\r\nbe held responsible when the fraud is discovered. More info on\r\nscams can be found at this web address: \r\n\r\nhttp://www.craigslist.org/about/scams\r\n\r\n\r\nThanks for using craigslist!"
      manage_url_from_body(body).should == manage_url
    end

    it "should return nil if body does not have listing number" do
      body = 'some body that odesnt have a manage_url'
      manage_url_from_body(body).should == nil
    end
  end

  describe "helpers for manage page" do
    before do
      @listing_url = "http://sfbay.craigslist.org/sfc/ele/2525590758.html"
      @craigslist_id = '2525590758'
      @price = "$1400"
      @location = "SOMA / south beach"
      @manage_page_body = '<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\n<html>\n<head>\n <base href=\"https://post.craigslist.org\">\n <title>craigslist | manage posting</title>\n <meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\">\n <link type=\"text/css\" rel=\"stylesheet\" media=\"all\" href=\"/styles/craigslist.css?v=9\">\n</head>\n\n<body id=\"pp\">\n<table width=\"100%\" id=\"header\" summary=\"header\">\n <tr valign=\"top\">\n  <td><a href=\"http://www.craigslist.org/\"><b>craigslist</b></a> &gt; manage posting<br></td>\n  <td width=\"10%\" class=\"highlight\" style=\"text-align: right; white-space: nowrap;\">\n\t\t\t<font face=\"sans-serif\">\n\t\t\t\t<b><a href=\"https://accounts.craigslist.org/login?rt=P&amp;rp=/manage/2525590758/ja3mp\">\n\t\t\t\tlog in to your account</a></b>\n\t\t\t\t<br><a href=\"https://accounts.craigslist.org/login/signup\">\n\t\t\t\t<small>(Apply for Account)</small></a>\n\t\t\t</font>\n\t\t</td>\n </tr>\n</table>\n\n<hr>\n<div class=\"managestatus\" style=\"background: lightgreen;\">\n  <table summary=\"status\">\n\t\n\t<tr><td colspan=2><p>Your posting can be seen at <a href=\"' + @listing_url + '\" target=\"_blank\">http://sfbay.craigslist.org/sfc/ele/2525590758.html</a>.</p>\n</td></tr>\n\t<tr><td><div class=\"managebutton\"><form action=\"/manage/2525590758/ja3mp\" method=\"POST\"><input type=\"hidden\" name=\"U2FsdGVkX18yMTA0NTIxMK11WLG4B_wzVJyBpmOrN2HpU_RIO.cVTOA\" value=\"edit\"><input type=\"hidden\" name=\"U2FsdGVkX18yMTA0NTIxMJAN5erD4wLLzGetfJwXkiNtvV1j6LOqiA\" value=\"U2FsdGVkX18yMTA0NTIxMGmJ_x-IEoUGyertSenpfFtHIww1q04Qcw\"><input type=\"submit\" name=\"go\" value=\"Edit this Posting\" class=\"managebtn\"></form></div></td><td>You can make changes to the content of your post.</td></tr>\n<tr><td><div class=\"managebutton\"><form action=\"/manage/2525590758/ja3mp\" method=\"GET\"><input type=\"hidden\" name=\"U2FsdGVkX18yMTA0NTIxMK11WLG4B_wzVJyBpmOrN2HpU_RIO.cVTOA\" value=\"delete\"><input type=\"submit\" name=\"go\" value=\"Delete this Posting\" class=\"managebtn\"></form></div></td><td>This will remove your posting from active listing.</td></tr>\n\n  </table>\n  <div style=\"clear: both;\"></div>\n</div>\n<hr>\n<div class=\"posting\">\n<div class=\"bchead\">\n SF bay area craigslist &gt; san francisco &gt; for sale / wanted &gt; electronics\n</div><h2>New 13\" MacBook Air 1.7GHz i5 4GB Ram 256GB HD - ' + @price + ' (' + @location + ')</h2>\n<hr>\nDate: 2011-08-02,  2:04AM PDT<br>\nReply to: <small><i>your anonymous craigslist address will appear here</i></small>\n<hr>\n<br>\n<div id=\"userbody\">\nThis is a brand new 13\" MacBook Air (the new one with the lit keyboard).  1.7 Ghz i5 processor, 4GB Ram, 256 GB Flash HD.  Please contact me ASAP if you are interested.  <!-- START CLTAGS -->\n\n\n<br><br><ul class=\"blurbs\">\n<li>its NOT ok to contact this poster with services or other commercial interests</ul>\n<!-- END CLTAGS -->\t\t<table summary=\"craigslist hosted images\">\n\t\t\t<tr>\n\t\t\t\t<td align=\"center\"></td>\n\t\t\t\t<td align=\"center\"></td>\n\t\t\t</tr>\n\t\t\t<tr>\n\t\t\t\t<td align=\"center\"></td>\n\t\t\t\t<td align=\"center\"></td>\n\t\t\t</tr>\n\t\t</table>\n\n</div>\nPostingID: ' + @craigslist_id + '<br>\n\n\n\n</div>\n<hr>\n</body>\n</html>\n'
    end

    describe "craigslist_id_from_manage_page_body" do
      it "should return listing number" do
        craigslist_id_from_manage_page_body(@manage_page_body).should == @craigslist_id
      end

      it "should not return listing number" do
        craigslist_id_from_manage_page_body("somethign random").should == nil
      end
    end

    describe "listing_url_from_manage_page_body" do
      it "should return listing url" do
        listing_url_from_manage_page_body(@manage_page_body).should == @listing_url
      end

      it "should return nil for the listing url" do
        listing_url_from_manage_page_body("this is something that is random").should == nil
      end
    end

    describe "listing_price_from_manage_page_body" do
      it "should return price" do
        listing_price_from_manage_page_body(@manage_page_body).should == @price
      end

      it "should return nil for the listing url" do
        listing_price_from_manage_page_body("this is something that is random").should == nil
      end
    end

    describe "listing_location_from_manage_page_body" do
      it "should return listing location" do
        listing_location_from_manage_page_body(@manage_page_body).should == @location
      end

      it "should return nil for the listing url" do
        listing_location_from_manage_page_body("this is something that is random").should == nil
      end
    end
  end

  describe "helpers for craigslist listing page" do
    describe "#listing_title_from_listing_body(body)" do
      it "should return title" do
        title = "iPad2 White, 16 GB, Wi-fi Only"
        body = '<html><body><title>' + title + '</title></body></html>'
        listing_title_from_listing_body(body).should == title
      end

      it "should not return nil" do
        body = '<html><body>random shit</body></html>'
        listing_title_from_listing_body(body).should == nil
      end
    end

    describe "listing_image_from_listing_body" do
      it "should return listing image" do
        image_path = 'http://images.craigslist.org/3n83m33pd5V35Z05U4b9ef86aea0305901a0e.jpg'
        body = '<table summary="craigslist hosted images">\n<tr>\n<td align="center"><img src="' + image_path + '" alt="image 0"></td>\n<td align="center"><img src="http://images.craigslist.org/3k13m83p75V65X05S6b9e852a00f623aa19b5.jpg" alt="image 1"></td>\n</tr>\n<tr>\n<td align="center"><img src="http://images.craigslist.org/3n93m63oc5O55Z05T6b9e11ef90b484a11d1c.jpg" alt="image 2"></td>\n<td align="center"><img src="http://images.craigslist.org/3n43k53l35O65X15R2b9e0ea7eb7cba161569.jpg" alt="image 3"></td>\n</tr>\n</table>'
        listing_image_from_listing_body(body).should == image_path
      end

      it "should return nil for the listing url" do
        listing_image_from_listing_body("this is something that is random").should == nil
      end
    end
  end
end