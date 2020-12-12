import StickySidebar from 'sticky-sidebar';

var sidebar = new StickySidebar('#sticky-container', {
  topSpacing: 80,
  bottomSpacing: 20,
  containerSelector: '#main-sticky-container',
  innerWrapperSelector: '#sticky'
});