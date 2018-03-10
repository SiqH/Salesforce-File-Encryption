<aura:component controller="EncryptionPOCController">
    <aura:attribute name="attachmentBody" type="String"/>
    
    <aura:attribute name="parentId" type="Id" default="0031N00001MxOr3" />
    <aura:attribute name="showLoadingSpinner" type="boolean" default="false" />
    <aura:attribute name="fileName" type="String" default="No File Selected.." />
    <aura:attribute name="isVisible" type="Boolean" default="false" />
    <aura:handler name="init" value="{!this}" action="{!c.onInit}" />
    
	<!-- PAGE HEADER -->
    <lightning:layout class="slds-page-header slds-page-header--object-home">
        <lightning:layoutItem >
            <lightning:icon iconName="standard:scan_card" alternativeText="QDE"/>
        </lightning:layoutItem>
        <lightning:layoutItem padding="horizontal-small">
            <div class="page-section page-header">
                <h2 class="slds-text-heading--medium">File Uploader</h2>
            </div>
        </lightning:layoutItem>
    </lightning:layout>
    <!-- / PAGE HEADER -->
    
    <aura:if isTrue="{!v.isVisible}">
        <lightning:layout >
            <lightning:layoutItem padding="around-small" size="6">
                <div aria-labelledby="newContactForm">
                    <form class="slds-form--stacked"> 
                        <lightning:input aura:id="fileId" type="file" name="file" onchange="{!c.handleFilesChange}" label="Upload File" multiple="false"/>
                        <div class="slds-text-body_small slds-text-color_error">{!v.fileName} </div>
                        <lightning:button label="Upload" 
                                          class="slds-m-top--medium"
                                          variant="brand"
                                          onclick="{!c.doSave}"/>
    
                    </form>
                </div>
            </lightning:layoutItem>
        </lightning:layout>
        
    </aura:if>
</aura:component>