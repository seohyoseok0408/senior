<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<section class="contact_section layout_padding-top">
  <div class="container">
    <div class="row">
      <div class="col-md-8 mx-auto">
        <div class="contact-form">
          <div class="heading_container">
            <h2>
              Get In Touch
            </h2>
          </div>
          <form action="">
            <input type="text" placeholder="Full name " />
            <div class="top_input">
              <input type="email" placeholder="Email" />
              <input type="text" placeholder="Phone Number" />
            </div>
            <input type="text" placeholder="Message" class="message_input" />
            <div class="btn-box">
              <button>
                Send
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>